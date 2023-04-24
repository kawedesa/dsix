import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/model/map/dialogs/building_creation_dialog.dart';
import 'package:flutter/material.dart';

class BuildingCreationButton extends StatelessWidget {
  final Function() fullRefresh;
  const BuildingCreationButton({
    super.key,
    required this.fullRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return AppCircularButton(
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
        size: 0.03);
  }
}
