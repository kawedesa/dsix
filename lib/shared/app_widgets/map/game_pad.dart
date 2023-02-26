import 'package:flutter/material.dart';
import 'dart:math' as math;

class GamePad extends StatefulWidget {
  final Color color;
  final Color cancelColor;
  final Function() onPanStart;
  final Function(double, double) onPanUpdate;
  final Function() onPanEnd;
  final Function() cancel;

  const GamePad({
    Key? key,
    required this.color,
    required this.cancelColor,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.cancel,
  }) : super(key: key);

  @override
  State<GamePad> createState() => _GamePadState();
}

class _GamePadState extends State<GamePad> {
  double gamePadSize = 125;
  late double innerSize = gamePadSize / 2;
  late Offset center = Offset(gamePadSize / 2, gamePadSize / 2);
  late Offset innerPosition = center;
  double inputDistance = 0;
  double inputAngle = 0;
  bool drag = false;

  void _calculateInnerPossition(Offset dragOffset) {
    double x =
        (center.dx - inputDistance * innerSize / 2 * math.cos(inputAngle));
    double y =
        (center.dy - inputDistance * innerSize / 2 * math.sin(inputAngle));
    innerPosition = Offset(x, y);
  }

  void _setAngle(Offset dragOffset) {
    inputAngle =
        math.atan2(center.dy - dragOffset.dy, center.dx - dragOffset.dx);
  }

  void _setDistance(Offset dragOffset) {
    inputDistance = ((center - dragOffset).distance / gamePadSize) - 0.2;

    if (inputDistance > 1) {
      inputDistance = 1;
    }
  }

  void _resetInput() {
    inputAngle = 0;
    inputDistance = 0;
    innerPosition = center;
  }

  Color getColor() {
    if (innerPosition == center || inputDistance > 0.2) {
      return widget.color;
    } else {
      return widget.cancelColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _resetInput();
    }

    return Stack(
      children: [
        Container(
          width: gamePadSize,
          height: gamePadSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getColor().withAlpha(100),
            border: Border.all(
              color: getColor(),
              width: 2,
            ),
          ),
        ),
        Positioned(
          left: innerPosition.dx - innerSize / 2,
          top: innerPosition.dy - innerSize / 2,
          child: GestureDetector(
            onPanStart: (details) {
              drag = true;
              widget.onPanStart();
            },
            onPanUpdate: (details) {
              _setDistance(details.localPosition);
              _setAngle(details.localPosition);
              _calculateInnerPossition(details.localPosition);

              if (inputDistance < 0.2) {
                widget.cancel();
              } else {
                widget.onPanUpdate(inputAngle + 1.5708, inputDistance);
              }
            },
            onPanEnd: (details) {
              drag = false;
              widget.onPanEnd();
            },
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor().withAlpha(200),
                border: Border.all(
                  color: getColor().withAlpha(200),
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
