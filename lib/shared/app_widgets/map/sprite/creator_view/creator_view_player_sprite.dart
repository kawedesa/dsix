import 'package:dsix/shared/app_widgets/map/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';

import '../../../../../model/player/player.dart';

class CreatorViewPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;
  final Function() onTap;
  const CreatorViewPlayerSprite(
      {super.key,
      required this.player,
      required this.color,
      required this.onTap});

  @override
  State<CreatorViewPlayerSprite> createState() =>
      _CreatorViewPlayerSpriteState();
}

class _CreatorViewPlayerSpriteState extends State<CreatorViewPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.player.position.dx -
          widget.player.attributes.vision.getRange() / 2,
      top: widget.player.position.dy -
          widget.player.attributes.vision.getRange() / 2,
      child: SizedBox(
        width: widget.player.attributes.vision.getRange(),
        height: widget.player.attributes.vision.getRange(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
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
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  widget.onTap();
                },
                onPanStart: (details) {},
                onPanUpdate: (details) {},
                onPanEnd: (details) {},
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.player.size),
                  child: SizedBox(
                      width: widget.player.size,
                      height: widget.player.size,
                      child: PlayerSpriteImage(
                          isDead: widget.player.life.isDead(),
                          color: widget.color,
                          race: widget.player.race)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
