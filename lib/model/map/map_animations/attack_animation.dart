import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AttackAnimation extends StatelessWidget {
  final ActionInfo attackInfo;

  const AttackAnimation({super.key, required this.attackInfo});

  Widget createAttackAnimation(ActionInfo attackInfo) {
    //TODO FIX ATTACK ANIMATION PLACEMENT

    double width = attackInfo.attack.range.min + attackInfo.attack.range.max;
    double height = attackInfo.attack.range.min + attackInfo.attack.range.max;
    Offset offset = Offset(width / 2, 0);

    String attackAnimation = 'thrust';

    switch (attackInfo.attack.name) {
      case 'bite':
        width = attackInfo.attack.range.width * 2;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'crush';
        break;
      case 'blast':
        width = attackInfo.attack.range.width * 2;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'crush';
        break;
      case 'claw':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'slash';
        break;
      case 'crush':
        width = attackInfo.attack.range.width * 2;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'crush';
        break;
      case 'jab':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(
            attackInfo.attack.range.min + attackInfo.attack.range.max / 2, 0);
        attackAnimation = 'thrust';
        break;
      case 'punch':
        width = attackInfo.attack.range.width * 2;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'crush';
        break;
      case 'shot':
        attackAnimation = 'shot';
        break;
      case 'slam':
        attackAnimation = 'slam';
        break;
      case 'swing':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'slash';
        break;
      case 'slash':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'slash';
        break;
      case 'throw':
        attackAnimation = 'shot';
        break;
      case 'thrust':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(
            attackInfo.attack.range.min + attackInfo.attack.range.max / 2, 0);
        attackAnimation = 'thrust';
        break;
      case 'tongue':
        width = attackInfo.attack.range.max;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(
            attackInfo.attack.range.min + attackInfo.attack.range.max / 2, 0);
        attackAnimation = 'thrust';

        break;
      case 'volley':
        attackAnimation = 'shot';
        break;
      case 'whip':
        width = attackInfo.attack.range.width * 2;
        height = attackInfo.attack.range.width * 2;
        offset = Offset(attackInfo.attack.range.min, 0);
        attackAnimation = 'crush';
        break;
    }

    return Transform.translate(
      offset: Offset(attackInfo.actionCenter.dx - width / 2,
          attackInfo.actionCenter.dy - height / 2),
      child: Transform.rotate(
        angle: attackInfo.angle + 1.5708,
        child: Transform.translate(
          offset: offset,
          child: SizedBox(
            width: width,
            height: height,
            child: RiveAnimation.asset(
              AppAnimations.attack,
              animations: [attackAnimation],
              fit: BoxFit.fill,
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
