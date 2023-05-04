import 'package:dsix/model/map/sprites/aura_sprite.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/sprites/npc/npc_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerViewNpcSprite extends StatelessWidget {
  final Npc npc;

  const PlayerViewNpcSprite({
    super.key,
    required this.npc,
  });

  Offset getPosition(Npc npc) {
    return Offset(npc.position.dx - getSpriteSize(npc) / 2,
        npc.position.dy - getSpriteSize(npc) / 2);
  }

  double getSpriteSize(Npc npc) {
    if (npc.attributes.vision.getRange() < 100) {
      return 100;
    } else {
      return npc.attributes.vision.getRange();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: getPosition(npc).dx,
      top: getPosition(npc).dy,
      child: SizedBox(
        width: getSpriteSize(npc),
        height: getSpriteSize(npc),
        child: Stack(
          children: [
            AuraSprite(auras: npc.effects.auras),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 7,
                height: 7,
                decoration: (npc.inActionArea(user.combat.actionArea.area))
                    ? BoxDecoration(
                        color: AppColors.cancel.withAlpha(200),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.cancel,
                          width: 0.3,
                        ),
                      )
                    : BoxDecoration(
                        color: AppColors.uiColorDark.withAlpha(25),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.uiColorDark.withAlpha(100),
                          width: 0.3,
                        ),
                      ),
              ),
            ),
            NpcSpriteImage(npc: npc),
          ],
        ),
      ),
    );
  }
}
