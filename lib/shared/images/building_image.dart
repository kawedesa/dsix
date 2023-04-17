import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildingImage extends StatelessWidget {
  final String name;
  final double size;
  const BuildingImage({super.key, required this.name, required this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages().getBuildingSprite(name),
      height: size,
      width: size,
    );
  }
}
