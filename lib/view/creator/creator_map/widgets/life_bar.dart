import 'package:dsix/model/combat/life.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';

class LifeBar extends StatelessWidget {
  final Life life;
  final double height;
  final double width;
  const LifeBar(
      {super.key,
      required this.life,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    double currentLife() {
      return life.current / life.max * width;
    }

    return Stack(children: [
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            width: width, height: height, color: AppColors.uiColorDark),
      ),
      Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              width: currentLife(), height: height, color: AppColors.negative)),
    ]);
  }
}
