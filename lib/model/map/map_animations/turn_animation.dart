import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TurnAnimation extends StatelessWidget {
  const TurnAnimation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.15,
      child: const RiveAnimation.asset(
        AppAnimations.turn,
        fit: BoxFit.fill,
      ),
    );
  }
}
