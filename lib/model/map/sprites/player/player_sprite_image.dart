import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/map/hit_box.dart';
import 'package:dsix/model/map/ui/effects_ui.dart';
import 'package:dsix/shared/images/player_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerSpriteImage extends StatelessWidget {
  final Player player;

  const PlayerSpriteImage({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: player.size * 0.9),
            child: TransparentPointer(
              transparent: true,
              child: Stack(
                children: [
                  PlayerImage(
                      race: player.race,
                      sex: player.sex,
                      size: player.size,
                      headMovement: player.size / 50,
                      effects: player.effects.currentEffects),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: EffectsUi(
                effects: player.effects.currentEffects,
                tempArmor: player.attributes.defense.tempArmor,
                tempVision: player.attributes.vision.tempVision),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: HitBox(
              size: player.size,
              hitBox: player.getHitBox(),
            )),
      ],
    );
  }
}
