import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NpcImage extends StatelessWidget {
  final String name;
  final double size;
  final Color? color;
  const NpcImage(
      {super.key, required this.name, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AppImages().getNpcSprite(
            name,
          ),
          width: size,
          height: size,
        ),
        SvgPicture.asset(
          AppImages().getNpcSprite(
            name,
          ),
          width: size,
          height: size,
          color: color,
        ),
      ],
    );
  }
}
