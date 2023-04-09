import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/action_area_sprite.dart';
import 'package:dsix/shared/app_widgets/map/map_animation/map_animation.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/vision_grid.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';

import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_action_npc_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_building_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_dead_npc_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_dead_player_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_player_sprite.dart';

import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/npc_action_buttons.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_building_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'ui/in_game_menu.dart';
import 'ui/selected_npc_ui.dart';

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
            maxScale: user.mapInfo.maxZoom,
            minScale: user.mapInfo.minZoom,
            child: SizedBox(
              width: user.mapInfo.mapSize,
              height: user.mapInfo.mapSize,
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
                  Stack(
                    children: _creatorMapController.createBuildingSprites(
                        buildings, refresh),
                  ),
                  ActionAreaSprite(
                    area: user.combat.actionArea.area,
                  ),
                  Stack(
                    children: _creatorMapController.createPlayerSprites(
                        user, players, npcs),
                  ),
                  Stack(
                    children: _creatorMapController.createNpcSprites(
                        user, npcs, refresh),
                  ),
                  _creatorMapController
                      .placeHereTarget(user.placeHere.getOffset()),
                  _mapAnimation.displayAttackAnimations(),
                  _mapAnimation.displayDamageAnimations(),
                ],
              ),
            ),
          ),
          _creatorMapController.displayTurn(game.turn.currentTurn),
          // ignore: prefer_const_constructors
          SelectedNpcUi(),
          // ignore: prefer_const_constructors
          SelectedBuildingUi(),
          NpcActionButtons(refresh: refresh),
          _mapAnimation.displayTurnAnimations(),
          InGameMenu(
            refresh: () {
              refresh();
            },
          ),
        ],
      ),
    );
  }
}

class CreatorMapActionModeController {
//SPRITES

  //BUILDINGS
  List<Widget> createBuildingSprites(
      List<Building> buildings, Function refresh) {
    List<Widget> buildingSprites = [];

    for (Building building in buildings) {
      buildingSprites.add(CreatorViewBuildingSprite(
        building: building,
        refresh: () {
          refresh();
        },
      ));
    }
    return buildingSprites;
  }

//NPCS
  List<Widget> createNpcSprites(User user, List<Npc> npcs, Function refresh) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        npcSprites.add(CreatorViewDeadNpcSprite(
          npc: npc,
        ));
      } else {
        npcSprites.add(CreatorViewActionNpcSprite(
          npc: npc,
          selected: user.checkSelectedNpc(npc.id),
          beingAttacked:
              user.combat.actionArea.area.contains(npc.position.getOffset()),
          refresh: () {
            refresh();
          },
        ));
      }
    }
    return npcSprites;
  }

//PLAYERS
  List<Widget> createPlayerSprites(
      User user, List<Player> players, List<Npc> npcs) {
    List<Widget> playerSprites = [];

    Path npcVisibleArea = getNpcsVisibleArea(user.mapInfo, npcs);

    for (Player player in players) {
      if (npcVisibleArea.contains(player.position.getOffset())) {
        if (player.life.isDead()) {
          playerSprites.add(CreatorViewDeadPlayerSprite(
            player: player,
            color: AppColors().getPlayerColor(player.id),
          ));
        } else {
          playerSprites.add(CreatorViewPlayerSprite(
            player: player,
            beingAttacked: user.combat.actionArea.area
                .contains(player.position.getOffset()),
            color: AppColors().getPlayerColor(player.id),
          ));
        }
      }
    }

    return playerSprites;
  }

  Path getNpcsVisibleArea(MapInfo mapInfo, List<Npc> npcs) {
    Path visibleArea = Path();
    visibleArea.fillType = PathFillType.evenOdd;

    for (Npc npc in npcs) {
      if (npc.life.isDead() == false) {
        Path npcVisibleArea = Path();
        Path npcVision = Path.combine(PathOperation.difference,
            npc.getVisionArea(), VisionGrid().getGrid(npc.position));

        if (npc.position.tile == 'grass' ||
            npc.attributes.vision.canSeeInvisible) {
          npcVisibleArea = npcVision;
        } else {
          npcVisibleArea =
              Path.combine(PathOperation.difference, npcVision, mapInfo.grass);
        }

        visibleArea =
            Path.combine(PathOperation.union, visibleArea, npcVisibleArea);
      }
    }
    return visibleArea;
  }

  Widget placeHereTarget(Offset placeHere) {
    return Positioned(
      left: placeHere.dx - 2.5,
      top: placeHere.dy - 2.5,
      child: Container(
        width: 5,
        height: 5,
        decoration: BoxDecoration(
          color: AppColors.negative.withAlpha(50),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.negative.withAlpha(200),
            width: 0.3,
          ),
        ),
      ),
    );
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
