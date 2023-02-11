import 'package:dsix/model/game/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/user.dart';
import '../../../../shared/app_colors.dart';
import '../../../../shared/app_images.dart';
import '../../../../shared/app_widgets/button/app_circular_button.dart';
import '../../../../shared/app_widgets/layout/app_separator_horizontal.dart';

class BottomNavigationPlayer extends StatelessWidget {
  final Function(int) changePage;
  final Function() refresh;

  const BottomNavigationPlayer(
      {super.key, required this.changePage, required this.refresh});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final game = Provider.of<Game>(context);

    return (game.phase == 'creation')
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSeparatorHorizontal(value: 0.05),
              AppCircularButton(
                  onTap: () {
                    changePage(0);
                    refresh();
                  },
                  icon: AppImages.inventory,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              AppCircularButton(
                  onTap: () {
                    changePage(1);
                    refresh();
                  },
                  icon: AppImages.shop,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              (user.player.ready)
                  ? AppCircularButton(
                      onTap: () {
                        user.player.iAmNotReady();
                        refresh();
                      },
                      icon: AppImages.confirm,
                      iconColor: user.color,
                      color: AppColors.selected,
                      borderColor: AppColors.selected,
                      size: 0.07)
                  : AppCircularButton(
                      onTap: () {
                        user.player.iAmReady();
                        refresh();
                      },
                      icon: AppImages.confirm,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.darkColor,
                      size: 0.07),
              const AppSeparatorHorizontal(value: 0.05),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSeparatorHorizontal(value: 0.05),
              AppCircularButton(
                  onTap: () {
                    changePage(0);
                    refresh();
                  },
                  icon: AppImages.inventory,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              AppCircularButton(
                  onTap: () {
                    changePage(1);
                    refresh();
                  },
                  icon: AppImages.map,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.07),
              const AppSeparatorHorizontal(value: 0.05),
            ],
          );
  }
}
