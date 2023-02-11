import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../model/user.dart';

class GamePad extends StatefulWidget {
  final Function() refresh;
  const GamePad({Key? key, required this.refresh}) : super(key: key);

  @override
  State<GamePad> createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> {
  double gamePadSize = 125;
  late double innerSize = gamePadSize / 2;
  late Offset center = Offset(gamePadSize / 2, gamePadSize / 2);
  Offset? innerPosition;
  Color? innerButtonColor;
  double? inputDistance;
  double? inputAngle;

  void _calculateInnerPossition(Offset dragOffset) {
    double x =
        (center.dx - inputDistance! * innerSize / 2 * math.cos(inputAngle!));
    double y =
        (center.dy - inputDistance! * innerSize / 2 * math.sin(inputAngle!));
    innerPosition = Offset(x, y);
  }

  void _setAngle(Offset dragOffset) {
    inputAngle =
        math.atan2(center.dy - dragOffset.dy, center.dx - dragOffset.dx);
  }

  void _setDistance(Offset dragOffset) {
    inputDistance = (center - dragOffset).distance / gamePadSize;

    if (inputDistance! > 1) {
      inputDistance = 1;
    }
  }

  void _resetInput() {
    inputAngle = null;
    inputDistance = null;
    innerButtonColor = null;
    innerPosition = null;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    innerButtonColor ??= Colors.green;
    innerPosition ??= center;
    inputAngle ??= 0.0;
    inputDistance ??= 0.0;

    return Stack(
      children: [
        Container(
          width: gamePadSize,
          height: gamePadSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(125, 125, 125, 0.6),
            border: Border.all(
              color: Color.fromRGBO(125, 125, 125, 0.75),
              width: 2,
            ),
          ),
        ),
        Positioned(
          left: innerPosition!.dx - innerSize / 2,
          top: innerPosition!.dy - innerSize / 2,
          child: GestureDetector(
            onPanStart: (details) {
              innerButtonColor = Colors.black;
            },
            onPanUpdate: (details) {
              _setDistance(details.localPosition);
              _setAngle(details.localPosition);
              _calculateInnerPossition(details.localPosition);
              user.setAttack(inputAngle! + 1.5708, inputDistance!);

              widget.refresh();
            },
            onPanEnd: (details) {
              user.confirmAttack();
              user.resetAttack();
              _resetInput();

              widget.refresh();
            },
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(72, 72, 72, 0.75),
                border: Border.all(
                  color: Color.fromRGBO(72, 72, 72, 0.75),
                  width: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
