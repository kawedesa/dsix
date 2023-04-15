import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerHeadImage extends StatefulWidget {
  final String race;
  final String sex;
  final double size;
  final double headMovement;
  final Color? color;
  final Duration duration;

  const PlayerHeadImage({
    super.key,
    required this.race,
    required this.sex,
    required this.size,
    required this.headMovement,
    this.color,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<PlayerHeadImage> createState() => _PlayerHeadImageState();
}

class _PlayerHeadImageState extends State<PlayerHeadImage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
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
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          0,
          widget.headMovement * shake(controller.value),
        ),
        child: child,
      ),
      child: (widget.color != null)
          ? SvgPicture.asset(
              AppImages().getPlayerHeadSprite(widget.race, widget.sex),
              width: widget.size,
              height: widget.size,
              color: widget.color,
            )
          : SvgPicture.asset(
              AppImages().getPlayerHeadSprite(widget.race, widget.sex),
              width: widget.size,
              height: widget.size,
            ),
    );
  }
}
