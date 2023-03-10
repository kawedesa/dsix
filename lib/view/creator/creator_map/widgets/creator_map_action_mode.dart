import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/map/action_area_sprite.dart';
import 'package:dsix/shared/app_widgets/map/attack_button.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
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
  final Function(Position) createNpc;
  final Building? selectedBuilding;
  final Function(Building) selectBuilding;
  final Function(Position) createBuilding;
  final Function() deselect;
  final Function(String, Color) displaySnackBar;

  const CreatorMapActionMode(
      {Key? key,
      required this.mapInfo,
      required this.selectedNpc,
      required this.selectNpc,
      required this.createNpc,
      required this.selectedBuilding,
      required this.selectBuilding,
      required this.createBuilding,
      required this.deselect,
      required this.displaySnackBar})
      : super(key: key);

  @override
  State<CreatorMapActionMode> createState() => _CreatorMapActionModeState();
}

class _CreatorMapActionModeState extends State<CreatorMapActionMode> {
  final CreatorMapActionModeController _creatorMapController =
      CreatorMapActionModeController();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);
    final buildings = Provider.of<List<Building>>(context);

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
                  _creatorMapController.deselector(widget.selectedNpc,
                      widget.selectedBuilding, widget.deselect),
                  Stack(
                    children: _creatorMapController.createBuildingSprites(
                        buildings,
                        widget.selectedBuilding,
                        widget.selectBuilding,
                        widget.deselect),
                  ),
                  ActionAreaSprite(
                    area: _creatorMapController.combat.actionArea.area,
                  ),
                  Stack(
                    children: _creatorMapController.createPlayerSprites(
                        widget.mapInfo, players, npcs),
                  ),
                  Stack(
                    children: _creatorMapController.createNpcSprites(npcs,
                        widget.selectedNpc, widget.selectNpc, widget.deselect),
                  ),
                  _creatorMapController.placeHereTarget(),
                ],
              ),
            ),
          ),
          _creatorMapController.displayTurn(game.turn.currentTurn),
          _creatorMapController.selectedNpcUi(
            widget.selectedNpc,
          ),
          _creatorMapController.selectedBuildingUi(
            widget.selectedBuilding,
          ),
          _creatorMapController.getAttackInput(
              npcs, players, widget.selectedNpc, refresh),
          _creatorMapController.actionButtons(context, widget.mapInfo, npcs,
              players, widget.selectedNpc, refresh),
          _creatorMapController.inGameMenu(
              widget.selectNpc, widget.selectBuilding),
          _creatorMapController.buildingPlacer(
              widget.mapInfo, widget.createBuilding, refresh),
          _creatorMapController.npcPlacer(
              widget.mapInfo, widget.createNpc, refresh),
        ],
      ),
    );
  }
}

class CreatorMapActionModeController {
//SPRITES

  //BUILDINGS
  List<Widget> createBuildingSprites(
      List<Building> buildings,
      Building? selectedBuilding,
      Function(Building) selectBuilding,
      Function deselect) {
    List<Widget> buildingSprites = [];

    for (Building building in buildings) {
      buildingSprites.add(CreatorViewBuildingSprite(
          building: building,
          selected: (building == selectedBuilding) ? true : false,
          selectBuilding: () {
            selectBuilding(building);
          },
          deselect: () {
            deselect();
          }));
    }

    return buildingSprites;
  }

//PLAYERS
  List<Widget> createPlayerSprites(
      MapInfo mapInfo, List<Player> players, List<Npc> npcs) {
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
            color: AppColors().getPlayerColor(player.id),
            onTap: () {},
          ));
        }
      }
    }

    return playerSprites;
  }

//NPCS
  List<Widget> createNpcSprites(
      List<Npc> npcs, Npc? selectedNpc, Function selectNpc, Function deselect) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        npcSprites.add(CreatorViewDeadNpcSprite(
          npc: npc,
        ));
      } else {
        npcSprites.add(CreatorViewActionNpcSprite(
          npc: npc,
          selected: (npc == selectedNpc) ? true : false,
          selectNpc: () {
            selectNpc(npc);
          },
          deselectNpc: () {
            deselect();
          },
        ));
      }
    }

    return npcSprites;
  }

  Path getNpcsVisibleArea(MapInfo mapInfo, List<Npc> npcs) {
    Path visibleArea = Path();

    for (Npc npc in npcs) {
      if (npc.life.isDead() == false) {
        Path playerVision = Path()..addPath(npc.getVisionArea(), Offset.zero);
        Path playerVisibleArea = Path();

        if (npc.position.tile != 'grass') {
          playerVisibleArea = Path.combine(
              PathOperation.difference, playerVision, mapInfo.grass);
        } else {
          playerVisibleArea = playerVision;
        }

        visibleArea.addPath(playerVisibleArea, Offset.zero);
      }
    }
    return visibleArea;
  }

  Widget selectedNpcUi(Npc? selectedNpc) {
    if (selectedNpc == null) {
      return const SizedBox();
    } else {
      return Align(
          alignment: const Alignment(
            0.0,
            -0.9,
          ),
          child: SelectedNpcUi(npc: selectedNpc));
    }
  }

  Widget selectedBuildingUi(Building? selectedBuilding) {
    if (selectedBuilding == null) {
      return const SizedBox();
    } else {
      return Align(
          alignment: const Alignment(
            0.0,
            -0.9,
          ),
          child: SelectedBuildingUi(building: selectedBuilding));
    }
  }

  Widget deselector(
      Npc? selectedNpc, Building? selectedBuilding, Function deselect) {
    if (selectedNpc == null && selectedBuilding == null) {
      return const SizedBox();
    } else {
      return MouseInput(
          getMousePosition: (mousePosition) {},
          onTap: () {
            deselect();
          });
    }
  }

  Widget inGameMenu(
      Function(Npc) selectNpc, Function(Building) selectBuilding) {
    if (placingSomething != 'false') {
      return const SizedBox();
    }
    return Align(
        alignment: Alignment.topLeft,
        child: InGameMenu(
          startPlacingNpc: (npc) {
            startPlacingNpc(npc, selectNpc);
          },
          startPlacingBuilding: (building) {
            startPlacingBuilding(building, selectBuilding);
          },
        ));
  }

  String placingSomething = 'false';
  Position placeHere = Position.empty();

  void startPlacingBuilding(
      Building building, Function(Building) selectBuilding) {
    selectBuilding(building);
    placingSomething = 'building';
  }

  void startPlacingNpc(Npc npc, Function(Npc) selectNpc) {
    selectNpc(npc);
    placingSomething = 'npc';
  }

  Widget buildingPlacer(
      MapInfo mapInfo, Function(Position) createBuilding, Function refresh) {
    if (placingSomething == 'building') {
      return MouseInput(getMousePosition: (mousePosition) {
        placeHere = Position(
            dx: mousePosition.dx / mapInfo.minZoom -
                mapInfo.getCanvasPosition().dx,
            dy: mousePosition.dy / mapInfo.minZoom -
                mapInfo.getCanvasPosition().dy -
                50 / mapInfo.minZoom,
            tile: '');
        refresh();
      }, onTap: () {
        createBuilding(placeHere);
        placeHere.reset();
        placingSomething = 'false';
      });
    } else {
      return const SizedBox();
    }
  }

  Widget npcPlacer(
      MapInfo mapInfo, Function(Position) createNpc, Function refresh) {
    if (placingSomething == 'npc') {
      return MouseInput(getMousePosition: (mousePosition) {
        placeHere = Position(
            dx: mousePosition.dx / mapInfo.minZoom -
                mapInfo.getCanvasPosition().dx,
            dy: mousePosition.dy / mapInfo.minZoom -
                mapInfo.getCanvasPosition().dy -
                50 / mapInfo.minZoom,
            tile: '');
        refresh();
      }, onTap: () {
        createNpc(placeHere);
        placeHere.reset();
        placingSomething = 'false';
      });
    } else {
      return const SizedBox();
    }
  }

  Widget placeHereTarget() {
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

  Combat combat = Combat();

  Widget actionButtons(context, MapInfo mapInfo, List<Npc> npcs,
      List<Player> players, Npc? selectedNpc, Function refresh) {
    if (selectedNpc == null) {
      return const SizedBox();
    }
    if (placingSomething != 'false') {
      return const SizedBox();
    }

    List<Widget> abilityButtons = [];

    for (Attack attack in selectedNpc.attacks) {
      abilityButtons.add(
        AttackButton(
            isAttacking: combat.isAttacking,
            icon: AppImages().getItemIcon('empty'),
            color: AppColors.uiColor,
            darkColor: AppColors.uiColorDark,
            startAttack: () {
              combat.startAttack(
                mapInfo.getPlayerOnScreenPosition(selectedNpc.position),
                selectedNpc.position,
                selectedNpc.attack(attack),
              );
              refresh();
            },
            cancelAttack: () {
              combat.cancelAction();
            },
            resetAttack: () {
              combat.resetActionArea();
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

  Widget getAttackInput(List<Npc> npcs, List<Player> players, Npc? selectedNpc,
      Function refresh) {
    Widget mouseInputWidget = const SizedBox();

    if (combat.isAttacking) {
      mouseInputWidget = MouseInput(
        getMousePosition: (mousePosition) {
          combat.setMousePosition(mousePosition);
          combat.setActionArea();
          refresh();
        },
        onTap: () {
          combat.confirmNpcAttack(npcs, players, selectedNpc);
          combat.cancelAction();
          refresh();
        },
      );

      return mouseInputWidget;
    }

    return mouseInputWidget;
  }
}
