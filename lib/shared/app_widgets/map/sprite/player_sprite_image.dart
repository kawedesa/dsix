import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerSpriteImage extends StatefulWidget {
  final bool isDead;
  final Color color;
  final String race;

  const PlayerSpriteImage(
      {Key? key, required this.isDead, required this.color, required this.race})
      : super(key: key);

  @override
  State<PlayerSpriteImage> createState() => _PlayerSpriteImageState();
}

class _PlayerSpriteImageState extends State<PlayerSpriteImage> {
  String bodyImage() {
    String selectedImage = '';

    switch (widget.race) {
      case 'dwarf':
        selectedImage = AppImages.dwarfBody;
        break;
      case 'orc':
        selectedImage = AppImages.orcBody;
        break;
      case 'elf':
        selectedImage = AppImages.elfBody;
        break;
    }

    return selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return (widget.isDead)
        ? Stack(
            children: [
              SvgPicture.asset(
                AppImages.grave,
                width: AppLayout.shortest(context) * 0.5,
              ),
              SvgPicture.asset(
                AppImages.graveColor,
                color: widget.color,
                width: AppLayout.shortest(context) * 0.5,
              ),
            ],
          )
        : Stack(
            children: [
              SvgPicture.asset(
                bodyImage(),
                width: AppLayout.shortest(context) * 0.5,
              ),
              PlayerSpriteHead(race: widget.race),
            ],
          );
  }
}

class PlayerSpriteHead extends StatefulWidget {
  final Duration duration;
  final double deltaY;
  final String race;

  const PlayerSpriteHead({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaY = 0.75,
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
        width: AppLayout.shortest(context) * 0.5,
      ),
    );
  }
}
