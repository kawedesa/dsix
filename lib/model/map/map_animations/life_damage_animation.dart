import 'dart:math';

import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/map/map_text.dart';
import 'package:dsix/shared/app_colors.dart';

import 'package:flutter/material.dart';

class LifeDamageAnimation extends StatefulWidget {
  final int damage;
  final Position position;
  const LifeDamageAnimation(
      {super.key, required this.damage, required this.position});

  @override
  State<LifeDamageAnimation> createState() => _LifeDamageAnimationState();
}

class _LifeDamageAnimationState extends State<LifeDamageAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  double animOffset = Random().nextDouble();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _opacity = Tween<double>(begin: 2, end: 0.0).animate(_controller);
    _scale = Tween<double>(begin: 2, end: 4).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double shake(double value) {
    double speed = value + animOffset;

    if (speed > 1) {
      speed -= 1;
    }

    return 4 * (0.5 - (0.5 - Curves.decelerate.transform(speed)).abs());
  }

  double goUp(double value) {
    return -value * 12;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 3,
      top: widget.position.dy - 5,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(
            shake(_controller.value),
            goUp(_controller.value),
          ),
          child: child,
        ),
        child: FadeTransition(
          opacity: _opacity,
          child: ScaleTransition(
            scale: _scale,
            child: MapText(
              text: (-1 * widget.damage).toString(),
              fontSize: 1.0,
              strokeColor: (widget.damage > 0)
                  ? const Color.fromARGB(255, 141, 21, 10)
                  : const Color.fromARGB(255, 38, 88, 36),
              paintColor:
                  (widget.damage > 0) ? AppColors.negative : AppColors.positive,
            ),
          ),
        ),
      ),
    );
  }
}
