import 'dart:math';

import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HitAnimation extends StatelessWidget {
  final ActionInfo actionInfo;
  final List<Target> targets;

  const HitAnimation(
      {super.key, required this.actionInfo, required this.targets});

  Widget createHitAnimation(ActionInfo actionInfo, List<Target> targets) {
    List<Widget> hitAnimation = [];
    double size = 15;

    for (Target target in targets) {
      if (target.life == 0 && actionInfo.attack.name == '') {
        continue;
      }

      if (target.armor > 0) {
        double randomRotation = Random().nextDouble();
        hitAnimation.add(Positioned(
          left: target.position.dx - size / 2,
          top: target.position.dy - size / 2,
          child: Transform.rotate(
            angle: randomRotation,
            child: SizedBox(
              width: size,
              height: size,
              child: const RiveAnimation.asset(
                AppAnimations.hit,
                animations: ['armor'],
              ),
            ),
          ),
        ));
      }

      if (target.life > 0) {
        double randomRotation = Random().nextDouble();
        hitAnimation.add(Positioned(
          left: target.position.dx - size / 2,
          top: target.position.dy - size / 2,
          child: Transform.rotate(
            angle: randomRotation,
            child: SizedBox(
              width: size,
              height: size,
              child: const RiveAnimation.asset(
                AppAnimations.hit,
                animations: ['life'],
              ),
            ),
          ),
        ));
      }
    }

    return Stack(
      children: hitAnimation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return createHitAnimation(actionInfo, targets);
  }
}
