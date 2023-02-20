import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../../../../model/combat/combat.dart';
import '../../../../model/item/item.dart';
import '../../../../model/user.dart';

class GamePad extends StatefulWidget {
  final Function() refresh;
  final Combat combat;

  final Item item;

  const GamePad(
      {Key? key,
      required this.refresh,
      required this.combat,
      required this.item})
      : super(key: key);

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
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);

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
            color: user.color.withAlpha(100),
            border: Border.all(
              color: user.color,
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
              widget.combat.setAttack(inputAngle! + 1.5708, inputDistance!,
                  user.player.position, widget.item);

              widget.refresh();
            },
            onPanEnd: (details) {
              widget.combat.confirmAttack(npcs, players);
              widget.combat.resetAttack();
              _resetInput();

              widget.refresh();
            },
            child: Container(
              width: innerSize,
              height: innerSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: user.color.withAlpha(200),
                border: Border.all(
                  color: user.color.withAlpha(200),
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
