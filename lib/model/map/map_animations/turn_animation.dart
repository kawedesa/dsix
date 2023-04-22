import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class TurnAnimation extends StatefulWidget {
  const TurnAnimation({super.key});

  @override
  State<TurnAnimation> createState() => _TurnAnimationState();
}

class _TurnAnimationState extends State<TurnAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    _opacity = Tween<double>(begin: 2.0, end: 0.0).animate(_controller);
    _scale = Tween<double>(begin: 1.25, end: 1.5).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TransparentPointer(
      transparent: true,
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Align(
          alignment: const Alignment(0, -0.5),
          child: FadeTransition(
            opacity: _opacity,
            child: ScaleTransition(
              scale: _scale,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(200),
                  border: Border.all(
                    color: Colors.black.withAlpha(255),
                    width: 3,
                  ),
                ),
                width: 275,
                height: 75,
                child: const Center(
                  child: AppText(
                      text: 'YOUR TURN',
                      fontSize: 0.01,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
