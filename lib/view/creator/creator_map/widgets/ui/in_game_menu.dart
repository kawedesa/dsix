import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/ui/place_here.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/button/building_creation_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/button/npc_creation_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/button/turn_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InGameMenu extends StatefulWidget {
  final Function() refresh;
  const InGameMenu({super.key, required this.refresh});

  @override
  State<InGameMenu> createState() => _InGameMenuState();
}

class _InGameMenuState extends State<InGameMenu> {
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                localRefresh();
              }),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(AppLayout.avarage(context) * 0.025,
                    AppLayout.avarage(context) * 0.035, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NpcCreationButton(
                        active: true,
                        fullRefresh: () {
                          widget.refresh();
                        }),
                    const AppSeparatorVertical(value: 0.02),
                    BuildingCreationButton(
                      active: true,
                      fullRefresh: () {
                        widget.refresh();
                      },
                    ),
                    const AppSeparatorVertical(value: 0.02),
                    TurnButton(fullRefresh: widget.refresh),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
