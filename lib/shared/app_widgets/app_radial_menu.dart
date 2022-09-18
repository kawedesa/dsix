import 'package:flutter/material.dart';
import 'dart:math';
import 'button/app_circular_button.dart';

class AppRadialMenu extends StatefulWidget {
  final List<AppCircularButton> buttonInfo;

  const AppRadialMenu({
    Key? key,
    required this.buttonInfo,
  }) : super(key: key);

  @override
  State<AppRadialMenu> createState() => _AppRadialMenuState();
}

class _AppRadialMenuState extends State<AppRadialMenu> {
  List<Widget> createMenu() {
    List<Widget> menu = [];

    double buttonSize = MediaQuery.of(context).size.shortestSide * 0.2;

    for (int i = 0; i < widget.buttonInfo.length; i++) {
      Offset buttonPosition =
          calculateButtonPosition(i, widget.buttonInfo.length, buttonSize);

      Widget newButton = Align(
        alignment: Alignment(buttonPosition.dx, buttonPosition.dy),
        child: widget.buttonInfo[i],
      );
      menu.add(newButton);
    }

    return menu;
  }

  Offset calculateButtonPosition(
      int buttonIndex, int numberOfButtons, double buttonSize) {
    double numberOfAngles = 6.28319 / numberOfButtons;

    double angle = (buttonIndex + 1) * numberOfAngles;

    double x = sin(angle);

    double y = cos(angle);

    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.shortestSide * 0.6,
        height: MediaQuery.of(context).size.shortestSide * 0.6,
        child: Stack(
          children: createMenu(),
        ),
      ),
    );
  }
}
