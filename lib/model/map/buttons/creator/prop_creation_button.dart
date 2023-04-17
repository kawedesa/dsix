import 'package:dsix/model/map/dialogs/prop_creation_dialog.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class PropCreationButton extends StatelessWidget {
  final bool active;
  final Function() fullRefresh;
  const PropCreationButton({
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
                    return const PropCreationDialog();
                  }).then((value) => fullRefresh());
            },
            icon: AppImages.prop,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.03)
        : AppCircularButton(
            icon: AppImages.prop,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.03);
  }
}
