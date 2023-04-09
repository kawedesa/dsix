import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_building_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_edit_npc_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/sprites/creator_view_spawner_sprite.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/game_creation_menu.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_building_ui.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/selected_npc_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorMapEditMode extends StatefulWidget {
  const CreatorMapEditMode({
    Key? key,
  }) : super(key: key);

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
    final user = Provider.of<User>(context);
    final spawners = Provider.of<List<Spawner>>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final buildings = Provider.of<List<Building>>(context);

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
                  _creatorMapController.createSpawnerSprites(spawners),
                  _creatorMapController.createBuildingSprites(
                    buildings,
                    refresh,
                  ),
                  _creatorMapController.createNpcSprites(user, npcs, refresh),
                  _creatorMapController
                      .placeHereTarget(user.placeHere.getOffset()),
                ],
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          SelectedNpcUi(),
          // ignore: prefer_const_constructors
          SelectedBuildingUi(),
          GameCreationMenu(
            refresh: () {
              refresh();
            },
          ),
        ],
      ),
    );
  }
}

class CreatorMapEditModeController {
//SPRITES
  //BUILDINGS
  Widget createBuildingSprites(List<Building> buildings, Function refresh) {
    List<Widget> buildingSprites = [];

    for (Building building in buildings) {
      buildingSprites.add(CreatorViewBuildingSprite(
        building: building,
        refresh: () {
          refresh();
        },
      ));
    }

    return Stack(
      children: buildingSprites,
    );
  }

//SPAWNER
  Widget createSpawnerSprites(List<Spawner> spawners) {
    List<Widget> spawnerSprites = [];

    for (Spawner spawner in spawners) {
      spawnerSprites.add(CreatorViewSpawnerSprite(
        spawner: spawner,
      ));
    }

    return Stack(
      children: spawnerSprites,
    );
  }

//NPC
  Widget createNpcSprites(User user, List<Npc> npcs, Function refresh) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      npcSprites.add(CreatorViewEditNpcSprite(
        npc: npc,
        selected: user.checkSelectedNpc(npc.id),
        refresh: () {
          refresh();
        },
      ));
    }

    return Stack(
      children: npcSprites,
    );
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
}
