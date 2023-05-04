import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/map/menu/map_menu.dart';
import 'package:dsix/model/map/sprites/action_area_sprite.dart';
import 'package:dsix/model/map/sprites/chest/creator_view_chest_sprite.dart';
import 'package:dsix/model/map/sprites/tile/creator_view_tile_sprite.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';

import 'package:dsix/model/map/map_animations/map_animation.dart';
import 'package:dsix/model/map/mouse_input.dart';
import 'package:dsix/model/map/vision_grid.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/model/map/sprites/npc/creator_view_action_npc_sprite.dart';
import 'package:dsix/model/map/sprites/building/creator_view_building_sprite.dart';
import 'package:dsix/model/map/sprites/npc/creator_view_dead_npc_sprite.dart';
import 'package:dsix/model/map/sprites/player/creator_view_dead_player_sprite.dart';
import 'package:dsix/model/map/sprites/player/creator_view_player_sprite.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/map/ui/selection/creator_selection_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../model/map/menu/in_game_menu.dart';
import '../../../../model/map/buttons/creator/npc_action_buttons.dart';

class CreatorMapActionMode extends StatefulWidget {
  const CreatorMapActionMode({
    Key? key,
  }) : super(key: key);

  @override
  State<CreatorMapActionMode> createState() => _CreatorMapActionModeState();
}

class _CreatorMapActionModeState extends State<CreatorMapActionMode> {
  final CreatorMapActionModeController _creatorMapController =
      CreatorMapActionModeController();
  final MapAnimation _mapAnimation = MapAnimation();
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);
    final buildings = Provider.of<List<Building>>(context);
    final tiles = Provider.of<List<Tile>>(context);
    final chests = Provider.of<List<Chest>>(context);
    final battleLog = Provider.of<List<BattleLog>>(context);

    _mapAnimation.checkBattleLog(battleLog);
    _mapAnimation.checkNpcTurn(game.turn);
    user.updateNpc(npcs);
    user.setNpcMode(game.turn.currentTurn);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: user.mapInfo.canvasController,
            constrained: false,
            panEnabled: true,
            maxScale: user.mapInfo.zoom,
            minScale: user.mapInfo.zoom,
            child: SizedBox(
              width: user.mapInfo.map.size,
              height: user.mapInfo.map.size,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    AppImages().getMapImage(game.map),
                    width: AppLayout.longest(context),
                    height: AppLayout.longest(context),
                  ),
                  MouseInput(
                      getMouseOffset: (mouseOffset) {},
                      active: user.somethingIsSelected(),
                      onTap: () {
                        user.deselect();
                        refresh();
                      }),
                  _creatorMapController.createTileSprites(tiles, refresh),
                  _creatorMapController.createBuildingSprites(
                      buildings, refresh),
                  ActionAreaSprite(
                    area: user.combat.actionArea.area,
                  ),
                  _mapAnimation.displayAttackAnimations(),
                  _creatorMapController.createChestSprites(chests, refresh),
                  _creatorMapController.createDeadNpcSprites(npcs),
                  _creatorMapController.createDeadPlayerSprites(
                      user.mapInfo, players, npcs),
                  _creatorMapController.createPlayerSprites(
                      user.mapInfo, players, npcs),
                  _creatorMapController.createNpcSprites(user, npcs, refresh),
                  _mapAnimation.displayTargetAnimations(),
                  _mapAnimation.displayAuraAnimations(),
                ],
              ),
            ),
          ),
          _creatorMapController.displayTurn(game.turn.currentTurn),

          // ignore: prefer_const_constructors
          CreatorSelectionUi(),

          NpcActionButtons(fullRefresh: refresh),
          _mapAnimation.displayTurnAnimations(),
          InGameMenu(
            refresh: () => refresh(),
          ),
          MapMenu(
            color: AppColors.uiColor,
            borderColor: AppColors.uiColorLight,
            refresh: () => refresh(),
          ),
        ],
      ),
    );
  }
}

class CreatorMapActionModeController {
//SPRITES
//TILES
  Widget createTileSprites(List<Tile> tiles, Function refresh) {
    List<Widget> tileSprites = [];

    for (Tile tile in tiles) {
      tileSprites.add(CreatorViewTileSprite(
        tile: tile,
        fullRefresh: () {
          refresh();
        },
      ));
    }

    return Stack(
      children: tileSprites,
    );
  }

  //BUILDINGS
  Widget createBuildingSprites(List<Building> buildings, Function refresh) {
    List<Widget> buildingSprites = [];

    for (Building building in buildings) {
      buildingSprites.add(CreatorViewBuildingSprite(
        building: building,
        fullRefresh: () {
          refresh();
        },
      ));
    }
    return Stack(children: buildingSprites);
  }

  //CHESTS
  Widget createChestSprites(List<Chest> chests, Function refresh) {
    List<Widget> chestSprites = [];

    for (Chest chest in chests) {
      chestSprites.add(CreatorViewChestSprite(
        chest: chest,
        fullRefresh: () {
          refresh();
        },
      ));
    }
    return Stack(
      children: chestSprites,
    );
  }

//NPCS
  Widget createDeadNpcSprites(List<Npc> npcs) {
    List<Widget> deadNpcSprites = [];

    for (Npc npc in npcs) {
      if (npc.life.isAlive()) {
        continue;
      }

      deadNpcSprites.add(CreatorViewDeadNpcSprite(
        npc: npc,
      ));
    }
    return Stack(
      children: deadNpcSprites,
    );
  }

  Widget createNpcSprites(User user, List<Npc> npcs, Function refresh) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        continue;
      }

      npcSprites.add(CreatorViewActionNpcSprite(
        npc: npc,
        fullRefresh: () {
          refresh();
        },
      ));
    }

    return Stack(children: npcSprites);
  }

//PLAYERS
  Widget createDeadPlayerSprites(
      MapInfo mapInfo, List<Player> players, List<Npc> npcs) {
    List<Widget> playerDeadSprites = [];

    Path npcVisibleArea = getNpcsVisibleArea(mapInfo, npcs);

    for (Player player in players) {
      if (!npcVisibleArea.contains(player.position.getOffset())) {
        continue;
      }
      if (player.life.isAlive()) {
        continue;
      }

      playerDeadSprites.add(CreatorViewDeadPlayerSprite(
        player: player,
      ));
    }

    return Stack(
      children: playerDeadSprites,
    );
  }

  Widget createPlayerSprites(
      MapInfo mapInfo, List<Player> players, List<Npc> npcs) {
    List<Widget> playerSprites = [];

    Path npcVisibleArea = getNpcsVisibleArea(mapInfo, npcs);

    for (Player player in players) {
      if (!npcVisibleArea.contains(player.position.getOffset())) {
        continue;
      }

      if (player.life.isDead()) {
        continue;
      }

      playerSprites.add(CreatorViewPlayerSprite(
        player: player,
      ));
    }

    return Stack(
      children: playerSprites,
    );
  }

  Path getNpcsVisibleArea(MapInfo mapInfo, List<Npc> npcs) {
    Path visibleArea = Path();
    visibleArea.fillType = PathFillType.evenOdd;

    for (Npc npc in npcs) {
      if (npc.life.isAlive()) {
        Path npcVisibleArea = Path();
        Path npcVision = Path.combine(PathOperation.difference,
            npc.getVisionArea(), VisionGrid().getGrid(npc.position));

        if (mapInfo.map.grass.contains(npc.position.getOffset()) ||
            npc.attributes.vision.canSeeInvisible) {
          npcVisibleArea = npcVision;
        } else {
          npcVisibleArea = Path.combine(
              PathOperation.difference, npcVision, mapInfo.map.grass);
        }

        visibleArea =
            Path.combine(PathOperation.union, visibleArea, npcVisibleArea);
      }
    }
    return visibleArea;
  }

  Widget displayTurn(String turn) {
    return Align(
      alignment: const Alignment(0.0, -0.98),
      child: AppText(
          text: '${turn.toUpperCase()} TURN',
          fontSize: 0.0125,
          letterSpacing: 0.001,
          color: Colors.black),
    );
  }
}
