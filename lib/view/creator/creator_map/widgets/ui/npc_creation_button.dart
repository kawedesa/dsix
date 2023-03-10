import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'npc_creation_dialog.dart';

class NpcCreationButton extends StatefulWidget {
  final bool active;
  final Function(Npc) startPlacingNpc;
  const NpcCreationButton(
      {super.key, required this.active, required this.startPlacingNpc});

  @override
  State<NpcCreationButton> createState() => _NpcCreationButtonState();
}

class _NpcCreationButtonState extends State<NpcCreationButton> {
  void createNpc(Npc selectedNpc, List<Npc> npcs) {
    int newNpcId = DateTime.now().millisecondsSinceEpoch;

    Npc newNpc = selectedNpc;
    newNpc.id = newNpcId;

    widget.startPlacingNpc(newNpc);
  }

  @override
  Widget build(BuildContext context) {
    final npcs = Provider.of<List<Npc>>(context);
    return (widget.active)
        ? AppCircularButton(
            onTap: () {
              setState(
                () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NpcCreationDialog(
                          chooseNpc: (npc) {
                            createNpc(npc, npcs);
                          },
                        );
                      });
                },
              );
            },
            icon: AppImages.npc,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.04)
        : AppCircularButton(
            icon: AppImages.npc,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.04);
  }
}
