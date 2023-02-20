import 'package:dsix/shared/app_widgets/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';

import '../../../model/player/player.dart';

class OtherPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;
  final Function() onTap;
  const OtherPlayerSprite(
      {super.key,
      required this.player,
      required this.color,
      required this.onTap});

  @override
  State<OtherPlayerSprite> createState() => _OtherPlayerSpriteState();
}

class _OtherPlayerSpriteState extends State<OtherPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.player.position.dx - widget.player.size / 2,
      top: widget.player.position.dy - widget.player.size - 3,
      child: SizedBox(
        width: widget.player.size,
        height: widget.player.size + 3,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(25),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color,
                    width: 0.3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  widget.onTap();
                },
                onPanStart: (details) {},
                onPanUpdate: (details) {},
                onPanEnd: (details) {},
                child: SizedBox(
                    width: widget.player.size,
                    height: widget.player.size,
                    child: PlayerSpriteImage(
                        isDead: widget.player.life.isDead(),
                        race: widget.player.race)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
