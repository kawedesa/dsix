import 'package:dsix/shared/app_widgets/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';

import '../../../model/player/player.dart';

class DeadPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;

  const DeadPlayerSprite({
    super.key,
    required this.player,
    required this.color,
  });

  @override
  State<DeadPlayerSprite> createState() => _DeadPlayerSpriteState();
}

class _DeadPlayerSpriteState extends State<DeadPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.player.position.dx - widget.player.size / 2,
        top: widget.player.position.dy - widget.player.size,
        child: SizedBox(
          width: widget.player.size,
          height: widget.player.size,
          child: PlayerSpriteImage(
              isDead: widget.player.life.isDead(), race: widget.player.race),
        ));
  }
}
