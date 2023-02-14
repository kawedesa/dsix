import 'package:dsix/model/combat/area_effect.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';

class User {
  Player player = Player.empty();
  Color color = Colors.transparent;
  Color lightColor = Colors.transparent;
  Color darkColor = Colors.transparent;

  void selectCreator() {
    color = AppColors.uiColor;
    lightColor = AppColors.uiColorLight;
    darkColor = AppColors.uiColorDark;
  }

  void selectPlayer(Player player) {
    this.player = player;

    switch (player.id) {
      case 'purple':
        color = AppColors.purple;
        lightColor = AppColors.purpleLight;
        darkColor = AppColors.purpleDark;
        break;
      case 'pink':
        color = AppColors.pink;
        lightColor = AppColors.pinkLight;
        darkColor = AppColors.pinkDark;
        break;
      case 'yellow':
        color = AppColors.yellow;
        lightColor = AppColors.yellowLight;
        darkColor = AppColors.yellowDark;
        break;
      case 'green':
        color = AppColors.green;
        lightColor = AppColors.greenLight;
        darkColor = AppColors.greenDark;
        break;
      case 'blue':
        color = AppColors.blue;
        lightColor = AppColors.blueLight;
        darkColor = AppColors.blueDark;
        break;
    }
  }

  void updatePlayer(List<Player> players) {
    for (Player player in players) {
      if (player.id == this.player.id) {
        this.player = player;
      }
    }
  }

  //   if (firstAction.time == 0) {
  //     firstAction.attack(
  //         player.id, angle, distanceScale, player.location.oldLocation);
  //     firstAction.aoe.setArea(
  //       angle,
  //       distanceScale,
  //       player.location.oldLocation,
  //       equipment,
  //     );
  //     return;
  //   }

  //   if (secondAction.time == 0) {
  //     secondAction.attack(
  //         player.id, angle, distanceScale, firstAction.location);
  //     secondAction.aoe
  //         .setArea(angle, distanceScale, firstAction.location, equipment);
  //     return;
  //   }
  // }

}
