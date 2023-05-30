import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/shared/images/action_area_image.dart';
import 'package:flutter/material.dart';

class ActionAreaAnimation extends StatefulWidget {
  final ActionInfo attackInfo;

  const ActionAreaAnimation({super.key, required this.attackInfo});

  @override
  State<ActionAreaAnimation> createState() => _ActionAreaAnimationState();
}

class _ActionAreaAnimationState extends State<ActionAreaAnimation>
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
      child: CustomPaint(
        painter: ActionAreaImage(
          area: ActionArea().getArea(widget.attackInfo),
        ),
      ),
    );
  }
}
