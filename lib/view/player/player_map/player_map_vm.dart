import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/map/sprites/prop/player_view_prop_sprite.dart';
import 'package:dsix/model/map/sprites/tile/player_view_tile_sprite.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/model/user/user.dart';
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
  //TILE
  Widget createTileSprites(List<Tile> tiles) {
    List<Widget> tileSprites = [];

    for (Tile tile in tiles) {
      if (tile.visibility == false) {
        continue;
      }
      tileSprites.add(PlayerViewTileSprite(
        tile: tile,
      ));
    }

    return Stack(
      children: tileSprites,
    );
  }

  //BUILDINGS
  Widget createBuildingSprites(User user, List<Building> buildings,
      List<Player> players, bool sharedTeamVison) {
    List<Widget> buildingSprites = [];

    Path canSeeInvisibleArea = Path();
    Path normalVisibleArea = Path();

    canSeeInvisibleArea =
        getCanSeeInvisibleArea(user, players, sharedTeamVison);
    normalVisibleArea = getNormalVisibleArea(user, players, sharedTeamVison);

    for (Building building in buildings) {
      if (building.alwaysVisible) {
        buildingSprites.add(PlayerViewBuildingSprite(building: building));
        continue;
      }

      if (canSeeInvisibleArea.contains(building.position.getOffset()) ||
          normalVisibleArea.contains(building.position.getOffset())) {
        buildingSprites.add(PlayerViewBuildingSprite(building: building));
      }
    }

    return Stack(
      children: buildingSprites,
    );
  }

  //CHEST
  Widget createPropSprites(
      User user, List<Prop> props, List<Player> players, bool sharedTeamVison) {
    List<Widget> propSprites = [];

    Path canSeeInvisibleArea = Path();
    Path normalVisibleArea = Path();

    canSeeInvisibleArea =
        getCanSeeInvisibleArea(user, players, sharedTeamVison);
    normalVisibleArea = getNormalVisibleArea(user, players, sharedTeamVison);

    for (Prop prop in props) {
      if (canSeeInvisibleArea.contains(prop.position.getOffset()) ||
          normalVisibleArea.contains(prop.position.getOffset())) {
        propSprites.add(PlayerViewPropSprite(prop: prop));
      }
    }

    return Stack(
      children: propSprites,
    );
  }

  //NPC
  Widget createDeadNpcSprites(
      User user, List<Npc> npcs, List<Player> players, bool sharedTeamVison) {
    List<Widget> deadNpcSprites = [];

    Path canSeeInvisibleArea = Path();
    Path normalVisibleArea = Path();

    canSeeInvisibleArea =
        getCanSeeInvisibleArea(user, players, sharedTeamVison);
    normalVisibleArea = getNormalVisibleArea(user, players, sharedTeamVison);

    for (Npc npc in npcs) {
      if (npc.life.isAlive()) {
        continue;
      }
      if (npc.invisible &&
          canSeeInvisibleArea.contains(npc.position.getOffset())) {
        deadNpcSprites.add(PlayerViewDeadNpcSprite(
          npc: npc,
        ));
        continue;
      }
      if (npc.invisible) {
        continue;
      }
      if (normalVisibleArea.contains(npc.position.getOffset()) ||
          canSeeInvisibleArea.contains(npc.position.getOffset())) {
        deadNpcSprites.add(PlayerViewDeadNpcSprite(
          npc: npc,
        ));
      }
    }
    return Stack(
      children: deadNpcSprites,
    );
  }

  Widget createNpcSprites(
      User user, List<Npc> npcs, List<Player> players, bool sharedTeamVison) {
    List<Widget> npcSprites = [];

    Path canSeeInvisibleArea = Path();
    Path normalVisibleArea = Path();

    canSeeInvisibleArea =
        getCanSeeInvisibleArea(user, players, sharedTeamVison);
    normalVisibleArea = getNormalVisibleArea(user, players, sharedTeamVison);

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        continue;
      }
      if (npc.invisible &&
          canSeeInvisibleArea.contains(npc.position.getOffset())) {
        npcSprites.add(PlayerViewNpcSprite(
          npc: npc,
        ));
        continue;
      }
      if (npc.invisible) {
        continue;
      }
      if (normalVisibleArea.contains(npc.position.getOffset()) ||
          canSeeInvisibleArea.contains(npc.position.getOffset())) {
        npcSprites.add(PlayerViewNpcSprite(
          npc: npc,
        ));
      }
    }
    return Stack(
      children: npcSprites,
    );
  }

  Path getCanSeeInvisibleArea(
      User user, List<Player> players, bool sharedTeamVision) {
    if (!sharedTeamVision) {
      if (!user.player.attributes.vision.canSeeInvisible) {
        return Path();
      }
      return user.player.getVisionArea();
    }

    Path canSeeInvisibleArea = Path();

    for (Player player in players) {
      if (!player.attributes.vision.canSeeInvisible) {
        continue;
      }
      canSeeInvisibleArea = Path.combine(
          PathOperation.union, canSeeInvisibleArea, player.getVisionArea());
    }
    return canSeeInvisibleArea;
  }

  Path getNormalVisibleArea(
      User user, List<Player> players, bool sharedTeamVision) {
    Path normalVisibleArea = Path();
    normalVisibleArea.fillType = PathFillType.evenOdd;

    if (!sharedTeamVision) {
      if (user.player.attributes.vision.canSeeInvisible) {
        return Path();
      }

      normalVisibleArea = user.player.getVisionArea();

      if (user.player.position.inGrass) {
        return normalVisibleArea;
      } else {
        normalVisibleArea = Path.combine(PathOperation.difference,
            normalVisibleArea, VisionGrid().getGrid(user.player.position));
        normalVisibleArea = Path.combine(PathOperation.difference,
            normalVisibleArea, user.mapInfo.map.grass);
        return normalVisibleArea;
      }
    }

    for (Player player in players) {
      if (player.attributes.vision.canSeeInvisible) {
        continue;
      }

      Path playerVision = player.getVisionArea();

      if (!player.position.inGrass) {
        playerVision = Path.combine(PathOperation.difference, playerVision,
            VisionGrid().getGrid(player.position));
        playerVision = Path.combine(
            PathOperation.difference, playerVision, user.mapInfo.map.grass);
      }
      normalVisibleArea =
          Path.combine(PathOperation.union, normalVisibleArea, playerVision);
    }

    return normalVisibleArea;
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
