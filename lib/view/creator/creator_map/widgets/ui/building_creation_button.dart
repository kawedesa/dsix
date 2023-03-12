import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/building_creation_dialog.dart';
import 'package:flutter/material.dart';

class BuildingCreationButton extends StatefulWidget {
  final bool active;
  final Function() refresh;
  const BuildingCreationButton({
    super.key,
    required this.active,
    required this.refresh,
  });

  @override
  State<BuildingCreationButton> createState() => _BuildingCreationButtonState();
}

class _BuildingCreationButtonState extends State<BuildingCreationButton> {
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
                        return const BuildingCreationDialog();
                      }).then((value) => widget.refresh());
                },
              );
            },
            icon: AppImages.building,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.04)
        : AppCircularButton(
            icon: AppImages.building,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.04);
  }
}