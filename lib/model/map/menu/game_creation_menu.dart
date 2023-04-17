import 'package:dsix/model/map/buttons/creator/prop_creation_button.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/model/map/mouse_input.dart';
import 'package:dsix/model/map/ui/place_here.dart';
import 'package:dsix/model/map/buttons/creator/building_creation_button.dart';
import 'package:dsix/model/map/buttons/creator/spawner_creation_button.dart';
import 'package:dsix/model/map/buttons/creator/start_game_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../buttons/creator/npc_creation_button.dart';

class GameCreationMenu extends StatefulWidget {
  final Function() refresh;

  const GameCreationMenu({
    super.key,
    required this.refresh,
  });

  @override
  State<GameCreationMenu> createState() => _GameCreationMenuState();
}

class _GameCreationMenuState extends State<GameCreationMenu> {
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final spawners = Provider.of<List<Spawner>>(context);
    final user = Provider.of<User>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          PlaceHere(
              position:
                  user.mapInfo.getOnScreenPosition(user.placeHere).getOffset()),
          MouseInput(
              active: (user.placingSomething == 'false') ? false : true,
              getMouseOffset: (mouseOffset) {
                user.setPlaceHere(mouseOffset);
                localRefresh();
              },
              onTap: () {
                if (user.placingSomething == 'building') {
                  user.createBuilding();
                  user.resetPlacing();
                  user.deselect();
                }

                if (user.placingSomething == 'npc') {
                  user.createNpc();
                  user.resetPlacing();
                  user.deselect();
                }

                if (user.placingSomething == 'prop') {
                  user.createProp();
                  user.resetPlacing();
                  user.deselect();
                }

                localRefresh();
              }),
          (user.placingSomething == 'false')
              ? Align(
                  alignment: const Alignment(0, 0.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppSeparatorVertical(value: 0.025),
                      SpawnerCreationButton(
                          active: (spawners.isEmpty) ? true : false,
                          fullRefresh: widget.refresh),
                      const AppSeparatorHorizontal(value: 0.01),
                      NpcCreationButton(
                        active: (spawners.isEmpty) ? false : true,
                        fullRefresh: () {
                          widget.refresh();
                        },
                      ),
                      const AppSeparatorHorizontal(value: 0.01),
                      BuildingCreationButton(
                          active: (spawners.isEmpty) ? false : true,
                          fullRefresh: () {
                            widget.refresh();
                          }),
                      const AppSeparatorHorizontal(value: 0.01),
                      PropCreationButton(
                          active: (spawners.isEmpty) ? false : true,
                          fullRefresh: () {
                            widget.refresh();
                          }),
                      const AppSeparatorHorizontal(value: 0.01),
                      StartGameButton(
                          active: (spawners.isEmpty) ? false : true),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
