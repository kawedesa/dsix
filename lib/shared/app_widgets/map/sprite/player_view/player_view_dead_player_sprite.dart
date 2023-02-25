import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewDeadPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;

  const PlayerViewDeadPlayerSprite({
    super.key,
    required this.player,
    required this.color,
  });

  @override
  State<PlayerViewDeadPlayerSprite> createState() =>
      _PlayerViewDeadPlayerSpriteState();
}

class _PlayerViewDeadPlayerSpriteState
    extends State<PlayerViewDeadPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.player.position.dx - widget.player.size / 2,
        top: widget.player.position.dy - widget.player.size,
        child: TransparentPointer(
          transparent: true,
          child: SizedBox(
            width: widget.player.size,
            height: widget.player.size,
            child: PlayerSpriteImage(
                isDead: widget.player.life.isDead(),
                color: widget.color,
                race: widget.player.race),
          ),
        ));
  }
}
