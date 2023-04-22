import 'package:dsix/model/combat/position.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuraActivationAnimation extends StatefulWidget {
  final String aura;
  final Position position;

  const AuraActivationAnimation(
      {super.key, required this.aura, required this.position});

  @override
  State<AuraActivationAnimation> createState() =>
      _AuraActivationAnimationState();
}

class _AuraActivationAnimationState extends State<AuraActivationAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();
    _opacity = Tween<double>(begin: 0.75, end: 0.0).animate(_controller);
    _scale = Tween<double>(begin: 0.5, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 2.5,
      top: widget.position.dy - 2.5,
      child: FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: SizedBox(
            width: 5,
            height: 5,
            child: SvgPicture.asset(
              AppImages().getEffectIcon(widget.aura),
            ),
          ),
        ),
      ),
    );
  }
}
