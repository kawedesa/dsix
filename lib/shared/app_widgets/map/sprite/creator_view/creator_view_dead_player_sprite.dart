import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewDeadPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;

  const CreatorViewDeadPlayerSprite({
    super.key,
    required this.player,
    required this.color,
  });

  @override
  State<CreatorViewDeadPlayerSprite> createState() =>
      _CreatorViewDeadPlayerSpriteState();
}

class _CreatorViewDeadPlayerSpriteState
    extends State<CreatorViewDeadPlayerSprite> {
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
