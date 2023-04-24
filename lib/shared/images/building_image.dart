import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildingImage extends StatelessWidget {
  final String name;
  final bool isFlipped;
  final double size;
  const BuildingImage(
      {super.key,
      required this.name,
      required this.isFlipped,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return (isFlipped)
        ? Transform.scale(
            scaleX: -1,
            child: SvgPicture.asset(
              AppImages().getBuildingSprite(name),
              height: size,
              width: size,
            ),
          )
        : SvgPicture.asset(
            AppImages().getBuildingSprite(name),
            height: size,
            width: size,
          );
  }
}
