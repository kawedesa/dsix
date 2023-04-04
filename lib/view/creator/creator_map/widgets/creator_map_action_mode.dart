import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/map/action_area_sprite.dart';
import 'package:dsix/shared/app_widgets/map/ui/action_button.dart';
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
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_building_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'ui/in_game_menu.dart';
import 'ui/selected_npc_ui.dart';

class CreatorMapActionMode extends StatefulWidget {
  final MapInfo mapInfo;
  final Npc? selectedNpc;
  final Function(Npc) selectNpc;
  final Function() duplicateNpc;
  final Function(Position) createNpc;
  final Building? selectedBuilding;
  final Function(Building) selectBuilding;
  final Function() duplicateBuilding;
  final Function(Position) createBuilding;
  final Function() deselect;

  const CreatorMapActionMode(
      {Key? key,
      required this.mapInfo,
      required this.selectedNpc,
      required this.selectNpc,
      required this.duplicateNpc,
      required this.createNpc,
      required this.selectedBuilding,
      required this.selectBuilding,
      required this.duplicateBuilding,
      required this.createBuilding,
      required this.deselect})
      : super(key: key);

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

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          InteractiveViewer(
            transformationController: widget.mapInfo.canvasController,
            constrained: false,
            panEnabled: true,
            maxScale: widget.mapInfo.minZoom,
            minScale: widget.mapInfo.minZoom,
            child: SizedBox(
              width: widget.mapInfo.mapSize,
              height: widget.mapInfo.mapSize,
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
                        widget.mapInfo,
                        players,
                        npcs,
                        user.combat.actionArea.area),
                  ),
                  Stack(
                    children: _creatorMapController.createNpcSprites(
                        widget.mapInfo,
                        npcs,
                        user.combat.actionArea.area,
                        refresh),
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
          _creatorMapController.getAttackInput(user, npcs, players, refresh),
          _creatorMapController.actionButtons(
              context, user, widget.mapInfo, npcs, players, refresh),
          _mapAnimation.displayTurnAnimations(),
          Align(
              alignment: Alignment.topLeft,
              child: InGameMenu(
                active: (user.placingSomething == 'false') ? true : false,
                refresh: () {
                  refresh();
                },
              )),
          //TODO JUNTAR ESSES MOUSEINPUTS AO INGAME MENU (SITUAÇÃO SIMILAR AO ACTION BUTTON DO PLAYER)
          MouseInput(
              active: (user.placingSomething == 'building') ? true : false,
              getMouseOffset: (mouseOffset) {
                user.setPlaceHere(mouseOffset, widget.mapInfo);
                refresh();
              },
              onTap: () {
                user.createBuilding();
                user.resetPlacing();
              }),
          MouseInput(
              active: (user.placingSomething == 'npc') ? true : false,
              getMouseOffset: (mouseOffset) {
                user.setPlaceHere(mouseOffset, widget.mapInfo);
                refresh();
              },
              onTap: () {
                user.createNpc();
                user.resetPlacing();
              }),
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
  List<Widget> createNpcSprites(
      MapInfo mapInfo, List<Npc> npcs, Path attackArea, Function refresh) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        npcSprites.add(CreatorViewDeadNpcSprite(
          npc: npc,
        ));
      } else {
        npcSprites.add(CreatorViewActionNpcSprite(
          npc: npc,
          mapInfo: mapInfo,
          beingAttacked: attackArea.contains(npc.position.getOffset()),
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
      MapInfo mapInfo, List<Player> players, List<Npc> npcs, Path attackArea) {
    List<Widget> playerSprites = [];

    Path npcVisibleArea = getNpcsVisibleArea(mapInfo, npcs);

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
            beingAttacked: attackArea.contains(player.position.getOffset()),
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

//COMBAT
//TODO CREATE NPC ACTION BUTTONS CLASS
  Widget actionButtons(context, User user, MapInfo mapInfo, List<Npc> npcs,
      List<Player> players, Function refresh) {
    if (user.selectedNpc == null) {
      return const SizedBox();
    }
    List<Widget> abilityButtons = [];

    for (Attack attack in user.selectedNpc!.attacks) {
      abilityButtons.add(
        ActionButton(
            isTakingAction: user.combat.isTakingAction,
            icon: AppImages().getItemIcon('empty'),
            color: AppColors.uiColor,
            darkColor: AppColors.uiColorDark,
            startAction: () {
              user.combat.startAttack(
                  mapInfo.getPlayerOnScreenPosition(user.selectedNpc!.position),
                  user.selectedNpc!.position,
                  user.selectedNpc!.attack(attack),
                  null,
                  user.selectedNpc!);
              refresh();
            },
            resetAction: () {
              user.combat.resetAction();
            },
            resetArea: () {
              user.combat.resetArea();
              refresh();
            }),
      );
    }

    return Align(
      alignment: const Alignment(
        0.0,
        0.5,
      ),
      child: SizedBox(
        height: AppLayout.avarage(context) * 0.1,
        width: AppLayout.avarage(context) * 0.75,
        child: AppRadialMenu(
          maxAngle: 60,
          buttonInfo: abilityButtons,
        ),
      ),
    );
  }

  //LEVAR ISSO AQUI PRA ACTION BUTTON CLASS
  Widget getAttackInput(
      User user, List<Npc> npcs, List<Player> players, Function refresh) {
    Widget mouseInputWidget = MouseInput(
      active: user.combat.isTakingAction,
      getMouseOffset: (mouseOffset) {
        user.combat.setMousePosition(mouseOffset);
        user.combat.setActionArea();
        refresh();
      },
      onTap: () {
        user.combat.confirmAttack(npcs, players);
        user.combat.resetAction();
        refresh();
      },
    );

    return mouseInputWidget;
  }
}
