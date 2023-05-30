import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AttackAnimation extends StatelessWidget {
  final ActionInfo attackInfo;

  const AttackAnimation({super.key, required this.attackInfo});

  @override
  Widget build(BuildContext context) {
    double size = attackInfo.attack.range.min + attackInfo.attack.range.max;

    return Transform.translate(
      offset: Offset(attackInfo.actionCenter.dx - size / 2,
          attackInfo.actionCenter.dy - size / 2),
      child: Transform.rotate(
        angle: attackInfo.angle + 1.5708,
        child: Transform.translate(
          offset: Offset(size / 2, 0),
          child: SizedBox(
            width: size,
            height: size,
            child: const RiveAnimation.asset(
              AppAnimations.attack,
            ),
          ),
        ),
      ),
    );
  }
}
