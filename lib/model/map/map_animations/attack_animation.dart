import 'package:dsix/model/map/sprites/action_area_sprite.dart';
import 'package:flutter/material.dart';

class AttackAnimation extends StatefulWidget {
  final Path attackArea;

  const AttackAnimation({super.key, required this.attackArea});

  @override
  State<AttackAnimation> createState() => _AttackAnimationState();
}

class _AttackAnimationState extends State<AttackAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000))
      ..forward();
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ActionAreaSprite(
        area: widget.attackArea,
      ),
    );
  }
}
