import 'dart:math';

import 'package:dsix/model/combat/position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/ui/map_text.dart';
import 'package:flutter/material.dart';

class DamageAnimation extends StatefulWidget {
  final int damage;
  final Position position;
  const DamageAnimation(
      {super.key, required this.damage, required this.position});

  @override
  State<DamageAnimation> createState() => _DamageAnimationState();
}

class _DamageAnimationState extends State<DamageAnimation>
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
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _scale = Tween<double>(begin: 0.5, end: 1.5).animate(_controller);
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

    return 4 * (0.5 - (0.5 - Curves.ease.transform(speed)).abs());
  }

  double goUp(double value) {
    return -value * 12;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 6,
      top: widget.position.dy - 15,
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
              isBold: true,
              text: (-1 * widget.damage).toString(),
              fontSize: 4,
              letterSpacing: 0.25,
              color:
                  (widget.damage > 0) ? AppColors.negative : AppColors.positive,
            ),
          ),
        ),
      ),
    );
  }
}
