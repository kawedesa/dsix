import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TileImage extends StatelessWidget {
  final String name;
  final bool verticalFlip;
  final bool horizontalFlip;
  final double rotation;
  final double size;
  const TileImage(
      {super.key,
      required this.name,
      required this.verticalFlip,
      required this.horizontalFlip,
      required this.rotation,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scaleX: (horizontalFlip) ? -1 : 1,
      scaleY: (verticalFlip) ? -1 : 1,
      child: Transform.rotate(
        angle: rotation,
        child: SvgPicture.asset(
          AppImages().getTileSprite(name),
          height: size,
          width: size,
        ),
      ),
    );
  }
}
