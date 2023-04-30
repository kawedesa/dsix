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

  double currentLife() {
    double currentLife = life.current / life.max * width;
    if (currentLife < 0) {
      currentLife = 0;
    }
    return currentLife;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(width: width, height: height, color: Colors.black),
        ),
        Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                width: currentLife(),
                height: height,
                color: AppColors.negative)),
      ]),
    );
  }
}
