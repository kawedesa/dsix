import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/map/sprites/chest/player_view_chest_sprite.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/map/vision_grid.dart';
import 'package:dsix/model/map/sprites/building/player_view_building_sprite.dart';
import 'package:dsix/model/map/sprites/npc/player_view_dead_npc_sprite.dart';
import 'package:dsix/model/map/sprites/player/player_view_dead_player_sprite.dart';
import 'package:dsix/model/map/sprites/npc/player_view_npc_sprite.dart';
import 'package:dsix/model/map/sprites/player/player_view_other_player_sprite.dart';
import 'package:dsix/model/map/sprites/player/player_view_player_sprite.dart';
import 'package:flutter/material.dart';
import '../../../model/npc/npc.dart';

class PlayerMapVM {
  //SPRITES

  //BUILDINGS
  Widget createBuildingSprites(User user, List<Building> buildings,
      List<Player> players, bool sharedTeamVison) {
    List<Widget> buildingSprites = [];

    Path playersVisibleArea = Path();
    if (sharedTeamVison) {
      playersVisibleArea = getPlayersSharedVision(user.mapInfo, players);
    } else {
      playersVisibleArea = getPlayerVision(user.mapInfo, user.player);
    }

    for (Building building in buildings) {
      if (building.alwaysVisible) {
        buildingSprites.add(PlayerViewBuildingSprite(
          building: building,
        ));
        continue;
      }

      if (!playersVisibleArea.contains(building.position.getOffset())) {
        continue;
      }
      buildingSprites.add(PlayerViewBuildingSprite(
        building: building,
      ));
    }

    return Stack(
      children: buildingSprites,
    );
  }

  //CHEST
  Widget createChestSprites(User user, List<Chest> chests, List<Player> players,
      bool sharedTeamVison) {
    List<Widget> chestSprites = [];

    Path playersVisibleArea = Path();
    if (sharedTeamVison) {
      playersVisibleArea = getPlayersSharedVision(user.mapInfo, players);
    } else {
      playersVisibleArea = getPlayerVision(user.mapInfo, user.player);
    }

    for (Chest chest in chests) {
      if (!playersVisibleArea.contains(chest.position.getOffset())) {
        continue;
      }

      chestSprites.add(PlayerViewChestSprite(
        chest: chest,
      ));
    }

    return Stack(
      children: chestSprites,
    );
  }

  //NPC
  Widget createDeadNpcSprites(
      User user, List<Npc> npcs, List<Player> players, bool sharedTeamVison) {
    List<Widget> npcSprites = [];

    Path playersVisibleArea = Path();

    if (sharedTeamVison) {
      playersVisibleArea = getPlayersSharedVision(user.mapInfo, players);
    } else {
      playersVisibleArea = getPlayerVision(user.mapInfo, user.player);
    }

    for (Npc npc in npcs) {
      if (!playersVisibleArea.contains(npc.position.getOffset())) {
        continue;
      }

      if (npc.life.isAlive()) {
        continue;
      }
      npcSprites.add(PlayerViewDeadNpcSprite(
        npc: npc,
      ));
    }

    return Stack(
      children: npcSprites,
    );
  }

  Widget createNpcSprites(
      User user, List<Npc> npcs, List<Player> players, bool sharedTeamVison) {
    List<Widget> npcSprites = [];
    Path playersVisibleArea = Path();

    if (sharedTeamVison) {
      playersVisibleArea = getPlayersSharedVision(user.mapInfo, players);
    } else {
      playersVisibleArea = getPlayerVision(user.mapInfo, user.player);
    }

    for (Npc npc in npcs) {
      if (!playersVisibleArea.contains(npc.position.getOffset())) {
        continue;
      }

      if (npc.life.isDead()) {
        continue;
      }
      npcSprites.add(PlayerViewNpcSprite(
        npc: npc,
      ));
    }

    return Stack(
      children: npcSprites,
    );
  }

  Path getPlayerVision(MapInfo mapInfo, Player player) {
    Path playerVisibleArea = Path();
    playerVisibleArea.fillType = PathFillType.evenOdd;

    Path playerVision = Path.combine(PathOperation.difference,
        player.getVisionArea(), VisionGrid().getGrid(player.position));

    if (player.position.tile == 'grass' ||
        player.attributes.vision.canSeeInvisible) {
      playerVisibleArea = playerVision;
    } else {
      playerVisibleArea =
          Path.combine(PathOperation.difference, playerVision, mapInfo.grass);
    }

    return playerVisibleArea;
  }

  Path getPlayersSharedVision(MapInfo mapInfo, List<Player> players) {
    Path visibleArea = Path();
    visibleArea.fillType = PathFillType.evenOdd;

    for (Player player in players) {
      if (player.life.isDead()) {
        continue;
      }

      Path playerVisibleArea = Path();
      Path playerVision = Path.combine(PathOperation.difference,
          player.getVisionArea(), VisionGrid().getGrid(player.position));

      if (player.position.tile == 'grass' ||
          player.attributes.vision.canSeeInvisible) {
        playerVisibleArea = playerVision;
      } else {
        playerVisibleArea =
            Path.combine(PathOperation.difference, playerVision, mapInfo.grass);
      }

      visibleArea =
          Path.combine(PathOperation.union, visibleArea, playerVisibleArea);
    }
    return visibleArea;
  }

  //PLAYER SPRITES
  Widget createDeadPlayerSprites(List<Player> players) {
    List<Widget> deadPlayerSprites = [];

    for (Player player in players) {
      if (player.life.isAlive()) {
        continue;
      }

      deadPlayerSprites.add(PlayerViewDeadPlayerSprite(
        player: player,
      ));
    }

    return Stack(
      children: deadPlayerSprites,
    );
  }

  Widget createPlayerSprites(User user, List<Player> players) {
    List<Widget> playerSprites = [];

    //OTHER PLAYERS
    for (Player otherPlayer in players) {
      if (otherPlayer == user.player) {
        continue;
      }
      if (otherPlayer.life.isDead()) {
        continue;
      }

      playerSprites.add(PlayerViewOtherPlayerSprite(
        player: otherPlayer,
      ));
    }

    //PLAYER
    if (user.player.life.isAlive()) {
      // ignore: prefer_const_constructors
      playerSprites.add(PlayerViewPlayerSprite());
    }

    return Stack(
      children: playerSprites,
    );
  }
}
