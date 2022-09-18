import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerSpriteHead extends StatefulWidget {
  final Duration duration;
  final double deltaY;
  final String race;

  const PlayerSpriteHead({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaY = 2.5,
    required this.race,
  });

  @override
  State<PlayerSpriteHead> createState() => _PlayerSpriteHeadState();
}

class _PlayerSpriteHeadState extends State<PlayerSpriteHead>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  String headImage() {
    String selectedImage = '';

    switch (widget.race) {
      case 'dwarf':
        selectedImage = AppImages.dwarfHead;
        break;
      case 'orc':
        selectedImage = AppImages.orcHead;
        break;
      case 'elf':
        selectedImage = AppImages.elfHead;
        break;
    }

    return selectedImage;
  }

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
          widget.deltaY * shake(controller.value),
        ),
        child: child,
      ),
      child: SvgPicture.asset(
        headImage(),
        width: MediaQuery.of(context).size.shortestSide * 0.5,
      ),
    );
  }
}
