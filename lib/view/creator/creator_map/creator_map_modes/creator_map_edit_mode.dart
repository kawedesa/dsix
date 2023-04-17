import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/map/sprites/prop/creator_view_prop_sprite.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/model/map/mouse_input.dart';
import 'package:dsix/model/map/sprites/building/creator_view_building_sprite.dart';
import 'package:dsix/model/map/sprites/npc/creator_view_edit_npc_sprite.dart';
import 'package:dsix/model/map/sprites/spawner/creator_view_spawner_sprite.dart';
import 'package:dsix/model/map/menu/game_creation_menu.dart';
import 'package:dsix/model/map/ui/selection/creator_selection_ui.dart';
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
    final buildings = Provider.of<List<Building>>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final props = Provider.of<List<Prop>>(context);

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
                      buildings, refresh),
                  _creatorMapController.createPropSprites(props, refresh),
                  _creatorMapController.createNpcSprites(user, npcs, refresh),
                ],
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          CreatorSelectionUi(),
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
        fullRefresh: () {
          refresh();
        },
      ));
    }

    return Stack(
      children: buildingSprites,
    );
  }

  //PROPS
  Widget createPropSprites(List<Prop> props, Function refresh) {
    List<Widget> propSprites = [];

    for (Prop prop in props) {
      propSprites.add(CreatorViewPropSprite(
        prop: prop,
        fullRefresh: () {
          refresh();
        },
      ));
    }
    return Stack(
      children: propSprites,
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
        fullRefresh: () {
          refresh();
        },
      ));
    }

    return Stack(
      children: npcSprites,
    );
  }
}
