import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_widgets/map/ui/effects_ui.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewOtherPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;
  final Function() onTap;
  const PlayerViewOtherPlayerSprite(
      {super.key,
      required this.player,
      required this.color,
      required this.onTap});

  @override
  State<PlayerViewOtherPlayerSprite> createState() =>
      _PlayerViewOtherPlayerSpriteState();
}

class _PlayerViewOtherPlayerSpriteState
    extends State<PlayerViewOtherPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.player.position.dx -
          widget.player.attributes.vision.getRange() / 2,
      top: widget.player.position.dy -
          widget.player.attributes.vision.getRange() / 2,
      child: TransparentPointer(
        transparent: true,
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.player.size * 2),
                    child: EffectsUi(
                        effects: widget.player.effects.currentEffects,
                        tempArmor: widget.player.attributes.defense.tempArmor,
                        tempVision: widget.player.attributes.vision.tempVision),
                  )),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.player.size),
                  child: SizedBox(
                      width: widget.player.size,
                      height: widget.player.size,
                      child: PlayerSpriteImage(
                        color: widget.color,
                        race: widget.player.race,
                        sex: widget.player.sex,
                      )),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: false,
                  child: GestureDetector(
                    onTap: () {
                      widget.onTap();
                    },
                    onPanStart: (details) {},
                    onPanUpdate: (details) {},
                    onPanEnd: (details) {},
                    child: Padding(
                      padding:
                          EdgeInsets.only(bottom: widget.player.size / 1.2),
                      child: Container(
                        width: widget.player.size / 4,
                        height: widget.player.size / 2,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
