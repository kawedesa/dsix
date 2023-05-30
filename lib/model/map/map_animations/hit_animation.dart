import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HitAnimation extends StatelessWidget {
  final List<Target> targets;

  const HitAnimation({super.key, required this.targets});

  Widget createHitAnimation(List<Target> targets) {
    List<Widget> hitAnimation = [];
    double size = 10;

    for (Target target in targets) {
      hitAnimation.add(Positioned(
        left: target.position.dx - size / 2,
        top: target.position.dy - size / 2,
        child: SizedBox(
          width: size,
          height: size,
          child: const RiveAnimation.asset(
            AppAnimations.hit,
          ),
        ),
      ));
    }

    return Stack(
      children: hitAnimation,
    );
  }

  @override
  Widget build(BuildContext context) {
    return createHitAnimation(targets);
  }
}
