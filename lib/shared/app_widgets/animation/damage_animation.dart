import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/map_text.dart';
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
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..forward();
    _opacity = Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _offset = Tween<Offset>(
            begin: const Offset(0.0, 0.1), end: const Offset(0.0, -0.5))
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
        child: MapText(
          text: widget.damage.toString(),
          fontSize: 4,
          letterSpacing: 1,
          color: (widget.damage < 0) ? AppColors.negative : AppColors.positive,
        ),
      ),
    );
  }
}
