import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class DamageAnimation extends StatefulWidget {
  final int damage;
  const DamageAnimation({super.key, required this.damage});

  @override
  State<DamageAnimation> createState() => _DamageAnimationState();
}

class _DamageAnimationState extends State<DamageAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.5))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: FadeTransition(
        opacity: _opacity,
        child: AppText(
          text: widget.damage.toString(),
          fontSize: 0.005,
          letterSpacing: 0.0001,
          color: Colors.white,
        ),
      ),
    );
  }
}
