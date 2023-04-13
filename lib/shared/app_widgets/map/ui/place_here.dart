import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaceHere extends StatefulWidget {
  final Offset position;
  const PlaceHere({super.key, required this.position});

  @override
  State<PlaceHere> createState() => _PlaceHereState();
}

class _PlaceHereState extends State<PlaceHere>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 500);
  final double deltaY = 3;

  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) =>
      2 * (0.5 - (0.5 - Curves.easeInOut.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.position.dx - 10,
      top: widget.position.dy - 20,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => Transform.translate(
          offset: Offset(
            0,
            deltaY * shake(controller.value),
          ),
          child: child,
        ),
        child: SvgPicture.asset(
          AppImages.placeHere,
          width: 15,
          height: 15,
          color: AppColors.uiColorDark,
        ),
      ),
    );
  }
}
