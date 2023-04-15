import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/dialog/building_creation_dialog.dart';
import 'package:flutter/material.dart';

class BuildingCreationButton extends StatelessWidget {
  final bool active;
  final Function() fullRefresh;
  const BuildingCreationButton({
    super.key,
    required this.active,
    required this.fullRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return (active)
        ? AppCircularButton(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const BuildingCreationDialog();
                  }).then((value) => fullRefresh());
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
