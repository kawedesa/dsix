import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerSpriteImage extends StatefulWidget {
  final Color color;
  final String race;
  final String sex;

  const PlayerSpriteImage(
      {Key? key, required this.color, required this.race, required this.sex})
      : super(key: key);

  @override
  State<PlayerSpriteImage> createState() => _PlayerSpriteImageState();
}

class _PlayerSpriteImageState extends State<PlayerSpriteImage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppImages().getPlayerBodySprite(widget.race, widget.sex),
          width: AppLayout.shortest(context) * 0.5,
        ),
        PlayerSpriteHead(race: widget.race, sex: widget.sex),
      ],
    );
  }
}

class PlayerSpriteHead extends StatefulWidget {
  final Duration duration;
  final double deltaY;
  final String race;
  final String sex;

  const PlayerSpriteHead({
    super.key,
    this.duration = const Duration(milliseconds: 500),
    this.deltaY = 0.75,
    required this.race,
    required this.sex,
  });

  @override
  State<PlayerSpriteHead> createState() => _PlayerSpriteHeadState();
}

class _PlayerSpriteHeadState extends State<PlayerSpriteHead>
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
          widget.deltaY * shake(controller.value),
        ),
        child: child,
      ),
      child: SvgPicture.asset(
        AppImages().getPlayerHeadSprite(widget.race, widget.sex),
        width: AppLayout.shortest(context) * 0.5,
      ),
    );
  }
}
