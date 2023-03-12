import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'npc_creation_dialog.dart';

class NpcCreationButton extends StatefulWidget {
  final bool active;
  final Function() refresh;
  const NpcCreationButton(
      {super.key, required this.active, required this.refresh});

  @override
  State<NpcCreationButton> createState() => _NpcCreationButtonState();
}

class _NpcCreationButtonState extends State<NpcCreationButton> {
  @override
  Widget build(BuildContext context) {
    return (widget.active)
        ? AppCircularButton(
            onTap: () {
              setState(
                () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NpcCreationDialog();
                      }).then((value) => widget.refresh());
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
