import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/shared/images/tile_image.dart';
import 'package:flutter/material.dart';

class PlayerViewTileSprite extends StatelessWidget {
  final Tile tile;

  const PlayerViewTileSprite({super.key, required this.tile});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: tile.position.dx - (tile.size / 2),
        top: tile.position.dy - (tile.size / 2),
        child: TileImage(
            name: tile.name,
            verticalFlip: tile.verticalFlip,
            horizontalFlip: tile.horizontalFlip,
            rotation: tile.rotation,
            size: tile.size));
  }
}
