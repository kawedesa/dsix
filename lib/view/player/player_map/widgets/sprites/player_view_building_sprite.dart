import 'package:dsix/model/building/building.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerViewBuildingSprite extends StatelessWidget {
  final Building building;

  const PlayerViewBuildingSprite({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: building.position.dx - (building.size / 2),
      top: building.position.dy - (building.size / 2),
      child: SizedBox(
        height: building.size,
        width: building.size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppImages().getBuildingIcon(building.name),
                height: building.size,
                width: building.size,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
