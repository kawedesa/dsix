import 'package:dsix/model/building/building.dart';
import 'package:dsix/shared/images/building_image.dart';
import 'package:flutter/material.dart';

class PlayerViewBuildingSprite extends StatelessWidget {
  final Building building;

  const PlayerViewBuildingSprite({super.key, required this.building});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: building.position.dx - (building.size / 2),
        top: building.position.dy - (building.size / 2),
        child: BuildingImage(
            name: building.name,
            isFlipped: building.isFlipped,
            size: building.size));
  }
}
