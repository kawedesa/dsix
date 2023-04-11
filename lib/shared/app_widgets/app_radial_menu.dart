import 'package:flutter/material.dart';
import 'dart:math';

class AppRadialMenu extends StatelessWidget {
  final List<Widget> buttonInfo;
  final double maxAngle;

  const AppRadialMenu({
    Key? key,
    required this.buttonInfo,
    required this.maxAngle,
  }) : super(key: key);

  Widget createMenu() {
    List<Widget> menu = [];

    for (int i = 0; i < buttonInfo.length; i++) {
      Offset buttonPosition = calculateButtonPosition(i, buttonInfo.length);

      Widget newButton = Align(
        alignment: Alignment(buttonPosition.dx, buttonPosition.dy),
        child: buttonInfo[i],
      );
      menu.add(newButton);
    }

    return Stack(
      children: menu,
    );
  }

  Offset calculateButtonPosition(int buttonIndex, int numberOfButtons) {
    double maxAngleInRadians = (maxAngle * pi) / 180;

    double angleValue = maxAngleInRadians / numberOfButtons;

    double adjustToCenter = 0;

    if (numberOfButtons.isOdd) {
      adjustToCenter = (numberOfButtons / 2).floor() * angleValue;
    } else {
      adjustToCenter =
          ((numberOfButtons / 2).floor() * angleValue) - angleValue / 2;
    }

    double currentAngle = buttonIndex * angleValue - adjustToCenter;

    double x = sin(currentAngle);

    double y = cos(currentAngle);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return createMenu();
  }
}
