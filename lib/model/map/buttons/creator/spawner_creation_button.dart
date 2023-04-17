import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class SpawnerCreationButton extends StatelessWidget {
  final bool active;
  final Function() fullRefresh;
  const SpawnerCreationButton({
    super.key,
    required this.active,
    required this.fullRefresh,
  });
  void createSpawner() {
    int id = DateTime.now().millisecondsSinceEpoch;
    Spawner newSpawner = Spawner.newSpawner(id, 50.0, 'players');
    newSpawner.set();
  }

  @override
  Widget build(BuildContext context) {
    return (active)
        ? AppCircularButton(
            onTap: () {
              createSpawner();
            },
            icon: AppImages.spawner,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.03)
        : AppCircularButton(
            icon: AppImages.spawner,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.03);
  }
}
