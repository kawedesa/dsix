import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/images/npc_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

import 'hit_box.dart';

class NpcSpriteImage extends StatelessWidget {
  final Npc npc;
  const NpcSpriteImage({super.key, required this.npc});

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
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(bottom: npc.size * 0.6),
            child: TransparentPointer(
              transparent: true,
              child: Stack(
                children: [
                  NpcImage(
                    npc: npc,
                    size: npc.size,
                  ),
                  NpcImage(
                    npc: npc,
                    size: npc.size,
                    color: getEffectsColor(npc.effects.currentEffects),
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: HitBox(
              size: npc.size,
              hitBox: npc.getHitBox(),
            )),
      ],
    );
  }
}
