import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/player_effects_ui.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewPlayerSprite extends StatefulWidget {
  final Player player;
  final bool beingAttacked;
  final Color color;

  const CreatorViewPlayerSprite({
    super.key,
    required this.player,
    required this.beingAttacked,
    required this.color,
  });

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
                  decoration: (widget.beingAttacked)
                      ? BoxDecoration(
                          color: AppColors.cancel.withAlpha(200),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.cancel,
                            width: 0.3,
                          ),
                        )
                      : BoxDecoration(
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
                    onTap: () {},
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
              PlayerEffectUi(player: widget.player),
            ],
          ),
        ),
      ),
    );
  }
}
