import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AttackAnimation extends StatelessWidget {
  final ActionInfo attackInfo;

  const AttackAnimation({super.key, required this.attackInfo});

  Widget createAttackAnimation(ActionInfo attackInfo) {
    double size = attackInfo.attack.range.min + attackInfo.attack.range.max;
    String attackAnimation = 'thrust';

    switch (attackInfo.attack.name) {
      case 'bite':
        attackAnimation = 'thrust';
        break;
      case 'blast':
        attackAnimation = 'thrust';
        break;
      case 'claw':
        attackAnimation = 'slash';
        break;
      case 'crush':
        attackAnimation = 'thrust';
        break;
      case 'jab':
        attackAnimation = 'thrust';
        break;
      case 'punch':
        attackAnimation = 'thrust';
        break;
      case 'shot':
        attackAnimation = 'thrust';
        break;
      case 'slam':
        attackAnimation = 'thrust';
        break;
      case 'swing':
        attackAnimation = 'slash';
        break;
      case 'slash':
        attackAnimation = 'slash';
        break;
      case 'throw':
        attackAnimation = 'thrust';
        break;
      case 'thrust':
        attackAnimation = 'thrust';
        break;
      case 'tongue':
        attackAnimation = 'thrust';
        break;
      case 'volley':
        attackAnimation = 'thrust';
        break;
      case 'whip':
        attackAnimation = 'thrust';
        break;
    }

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
            child: RiveAnimation.asset(
              AppAnimations.attack,
              animations: [attackAnimation],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return createAttackAnimation(attackInfo);
  }
}
