import 'package:dsix/model/combat/life.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';

class LifeBar extends StatelessWidget {
  final Life life;
  const LifeBar({super.key, required this.life});

  @override
  Widget build(BuildContext context) {
    double currentLife() {
      return life.current / life.max * 200;
    }

    return Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: double.infinity, height: 15, color: AppColors.uiColorDark),
      ),
      Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: currentLife(), height: 15, color: AppColors.negative)),
    ]);
  }
}
