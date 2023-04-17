import 'package:dsix/model/effect/effect.dart';
import 'package:dsix/shared/images/player_head_image.dart';
import 'package:flutter/material.dart';
import 'player_body_image.dart';

class PlayerImage extends StatelessWidget {
  final String race;
  final String sex;
  final double size;
  final double headMovement;
  final List<Effect> effects;
  const PlayerImage({
    super.key,
    required this.race,
    required this.sex,
    required this.size,
    required this.headMovement,
    required this.effects,
  });

  Color getEffectsColor(List<Effect> effects) {
    if (effects.isEmpty) {
      return Colors.transparent;
    }
    int a = 0;
    int r = 255;
    int g = 255;
    int b = 255;

    for (Effect effect in effects) {
      switch (effect.name) {
        case 'burn':
          a = 75;
          r -= 68;
          g -= 175;
          b -= 255;

          break;
        case 'poison':
          a = 75;
          r -= 192;
          g -= 158;
          b -= 255;
          break;
      }
    }

    return Color.fromARGB(a, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlayerBodyImage(
          race: race,
          sex: sex,
          size: size,
        ),
        PlayerBodyImage(
          race: race,
          sex: sex,
          size: size,
          color: getEffectsColor(effects),
        ),
        PlayerHeadImage(
          race: race,
          sex: sex,
          size: size,
          headMovement: headMovement,
        ),
        PlayerHeadImage(
          race: race,
          sex: sex,
          size: size,
          headMovement: headMovement,
          color: getEffectsColor(effects),
        ),
      ],
    );
  }
}
