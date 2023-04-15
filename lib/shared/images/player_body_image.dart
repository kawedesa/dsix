import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerBodyImage extends StatelessWidget {
  final String race;
  final String sex;
  final double size;
  final Color? color;

  const PlayerBodyImage(
      {super.key,
      required this.race,
      required this.sex,
      required this.size,
      this.color});

  @override
  Widget build(BuildContext context) {
    return (color != null)
        ? SvgPicture.asset(
            AppImages().getPlayerBodySprite(race, sex),
            width: size,
            height: size,
            color: color,
          )
        : SvgPicture.asset(
            AppImages().getPlayerBodySprite(race, sex),
            width: size,
            height: size,
          );
  }
}
