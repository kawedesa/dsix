import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/sprites/npc/npc_sprite_image.dart';
import 'package:dsix/model/map/ui/effects_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerViewNpcSprite extends StatelessWidget {
  final Npc npc;

  const PlayerViewNpcSprite({
    super.key,
    required this.npc,
  });

  bool checkBeingAttacked(User user) {
    if (user.combat.actionArea.area.contains(npc.position.getOffset())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: npc.position.dx - npc.attributes.vision.getRange() / 2,
      top: npc.position.dy - npc.attributes.vision.getRange() / 2,
      child: SizedBox(
        width: npc.attributes.vision.getRange(),
        height: npc.attributes.vision.getRange(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 7,
                height: 7,
                decoration: (checkBeingAttacked(user))
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
