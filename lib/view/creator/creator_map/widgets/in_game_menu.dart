import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/creator/creator_map/widgets/npc_creation_button.dart';
import 'package:flutter/material.dart';

class InGameMenu extends StatefulWidget {
  final Function(Npc) startPlacingNpc;

  const InGameMenu({
    super.key,
    required this.startPlacingNpc,
  });

  @override
  State<InGameMenu> createState() => _InGameMenuState();
}

class _InGameMenuState extends State<InGameMenu> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.fromLTRB(AppLayout.avarage(context) * 0.025,
              AppLayout.avarage(context) * 0.035, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NpcCreationButton(
                active: true,
                startPlacingNpc: (npc) {
                  widget.startPlacingNpc(npc);
                },
              ),
              const AppSeparatorVertical(value: 0.02),
              NpcCreationButton(
                active: false,
                startPlacingNpc: (npc) {},
              ),
              const AppSeparatorVertical(value: 0.02),
              NpcCreationButton(
                active: false,
                startPlacingNpc: (npc) {},
              ),
            ],
          ),
        ));
  }
}
