import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/player/player.dart';
import 'package:flutter/material.dart';
import 'sprite_effects.dart';

class PlayerEffectUi extends StatelessWidget {
  final Player player;
  const PlayerEffectUi({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    List<Widget> effectsIcons = [];

    if (player.attributes.defense.tempDefense != 0) {
      effectsIcons.add(
        SpriteEffects(
            effect: Effect(
                name: 'tempArmor',
                description: 'description',
                value: player.attributes.defense.tempDefense,
                countdown: 0)),
      );
    }

    if (player.attributes.vision.tempVision != 0) {
      effectsIcons.add(
        SpriteEffects(
            effect: Effect(
                name: 'tempVision',
                description: 'description',
                value: 0,
                countdown: 0)),
      );
    }

    if (player.effects.currentEffects.isNotEmpty) {
      for (Effect effect in player.effects.currentEffects) {
        effectsIcons.add(
          SpriteEffects(
            effect: effect,
          ),
        );
      }
    }

    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: player.size * 1.8),
        child: SizedBox(
          width: 3.1 * effectsIcons.length,
          height: 3.1 * effectsIcons.length,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: effectsIcons,
          ),
        ),
      ),
    );
  }
}
