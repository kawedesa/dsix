import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/shared/app_widgets/map/vision_grid.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_building_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_dead_npc_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_dead_player_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_npc_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_other_player_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_player_sprite.dart';
import 'package:flutter/material.dart';
import '../../../model/npc/npc.dart';

class PlayerMapVM {
  //SPRITES
  //NPC

  Widget createDeadNpcSprites(User user, List<Npc> npcs, List<Player> players) {
    List<Widget> npcSprites = [];

    Path playersVisibleArea = getPlayersVisibleArea(user.mapInfo, players);

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

  Widget createNpcSprites(User user, List<Npc> npcs, List<Player> players) {
    List<Widget> npcSprites = [];

    Path playersVisibleArea = getPlayersVisibleArea(user.mapInfo, players);

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

  Path getPlayersVisibleArea(MapInfo mapInfo, List<Player> players) {
    Path visibleArea = Path();
    visibleArea.fillType = PathFillType.evenOdd;

    for (Player player in players) {
      if (player.life.isDead() == false) {
        Path playerVisibleArea = Path();
        Path playerVision = Path.combine(PathOperation.difference,
            player.getVisionArea(), VisionGrid().getGrid(player.position));

        if (player.position.tile == 'grass' ||
            player.attributes.vision.canSeeInvisible) {
          playerVisibleArea = playerVision;
        } else {
          playerVisibleArea = Path.combine(
              PathOperation.difference, playerVision, mapInfo.grass);
        }

        visibleArea =
            Path.combine(PathOperation.union, visibleArea, playerVisibleArea);
      }
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

  //BUILDINGS
  Widget createBuildingSprites(List<Building> buildings) {
    List<Widget> buildingSprites = [];
    for (Building building in buildings) {
      buildingSprites.add(PlayerViewBuildingSprite(
        building: building,
      ));
    }

    return Stack(
      children: buildingSprites,
    );
  }
}
