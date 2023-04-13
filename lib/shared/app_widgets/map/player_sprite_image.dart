import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/images/player_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerSpriteImage extends StatelessWidget {
  final Player player;

  const PlayerSpriteImage({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: player.size),
        child: TransparentPointer(
          transparent: true,
          child: PlayerImage(
              player: player,
              size: player.size,
              headMovement: player.size / 50),
        ),
      ),
    );
  }
}
