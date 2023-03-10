import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_building_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_edit_npc_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_spawner_sprite.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/game_creation_menu.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_building_ui.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_npc_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorMapEditMode extends StatefulWidget {
  final MapInfo mapInfo;
  final Npc? selectedNpc;
  final Function(Npc) selectNpc;
  final Function(Position) createNpc;
  final Building? selectedBuilding;
  final Function(Building) selectBuilding;
  final Function(Position) createBuilding;
  final Function() deselect;
  final Function(String, Color) displaySnackBar;

  const CreatorMapEditMode(
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
  State<CreatorMapEditMode> createState() => _CreatorMapEditModeState();
}

class _CreatorMapEditModeState extends State<CreatorMapEditMode> {
  final CreatorMapEditModeController _creatorMapController =
      CreatorMapEditModeController();

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    final npcs = Provider.of<List<Npc>>(context);
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
                  Stack(
                    children:
                        _creatorMapController.createSpawnerSprites(spawners),
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
          _creatorMapController.selectedBuildingUi(
            widget.selectedBuilding,
          ),
          _creatorMapController.selectedNpcUi(
            widget.selectedNpc,
          ),
          _creatorMapController.gameCreationMenu(
              widget.displaySnackBar, widget.selectBuilding, widget.selectNpc),
          _creatorMapController.buildingPlacer(
              widget.mapInfo, widget.createBuilding, refresh),
          _creatorMapController.npcPlacer(
              widget.mapInfo, widget.createNpc, refresh),
        ],
      ),
    );
  }
}

class CreatorMapEditModeController {
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

//SPAWNER
  List<Widget> createSpawnerSprites(List<Spawner> spawners) {
    List<Widget> spawnerSprites = [];

    for (Spawner spawner in spawners) {
      spawnerSprites.add(CreatorViewSpawnerSprite(
        spawner: spawner,
      ));
    }

    return spawnerSprites;
  }

//NPC
  List<Widget> createNpcSprites(
      List<Npc> npcs, Npc? selectedNpc, Function selectNpc, Function deselect) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      npcSprites.add(CreatorViewEditNpcSprite(
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

    return npcSprites;
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

  Widget gameCreationMenu(Function(String, Color) displaySnackbar,
      Function(Building) selectBuilding, Function(Npc) selectNpc) {
    if (placingSomething != 'false') {
      return const SizedBox();
    } else {
      return GameCreationMenu(
        startPlacingNpc: (npc) {
          startPlacingNpc(npc, selectNpc);
        },
        startPlacingBuilding: (building) {
          startPlacingBuilding(building, selectBuilding);
        },
        displaySnackbar: (text, color) {
          displaySnackbar(text, color);
        },
      );
    }
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
}
