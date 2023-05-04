import 'dart:math';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/map/map_text.dart';
import 'package:flutter/material.dart';

class GoldAnimation extends StatefulWidget {
  final int amount;
  final Position position;
  const GoldAnimation(
      {super.key, required this.amount, required this.position});

  @override
  State<GoldAnimation> createState() => _GoldAnimationState();
}

class _GoldAnimationState extends State<GoldAnimation>
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

    return 4 * (0.5 - (0.5 - Curves.easeInOutBack.transform(speed)).abs());
  }

  double goUp(double value) {
    return -value * 12;
  }

  String getAmount() {
    int displayAmount = -1 * widget.amount;

    if (displayAmount < 0) {
      return '-\$${displayAmount.abs()}';
    } else {
      return '\$$displayAmount';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 3,
      top: widget.position.dy - 10,
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
              text: getAmount(),
              fontSize: 0.8,
              paintColor: (widget.amount > 0)
                  ? const Color.fromARGB(255, 187, 22, 22)
                  : const Color.fromARGB(255, 150, 129, 33),
              strokeColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
