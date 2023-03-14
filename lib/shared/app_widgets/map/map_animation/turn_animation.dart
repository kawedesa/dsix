import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TurnAnimation extends StatefulWidget {
  const TurnAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<TurnAnimation> createState() => _TurnAnimationState();
}

class _TurnAnimationState extends State<TurnAnimation> {
  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.asset(
      AppAnimations.turn,
      fit: BoxFit.fill,
    );
  }
}
