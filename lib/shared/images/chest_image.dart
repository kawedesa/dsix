import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChestImage extends StatelessWidget {
  final String name;
  final bool open;
  final double size;
  const ChestImage(
      {super.key, required this.name, required this.open, required this.size});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages().getChestSprite(name, open),
      height: size,
      width: size,
    );
  }
}
