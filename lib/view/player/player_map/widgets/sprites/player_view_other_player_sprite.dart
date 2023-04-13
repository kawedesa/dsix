import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/ui/effects_ui.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewOtherPlayerSprite extends StatelessWidget {
  final Player player;

  const PlayerViewOtherPlayerSprite({super.key, required this.player});

  bool checkBeingAttacked(User user) {
    if (user.combat.actionArea.area.contains(player.position.getOffset())) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Positioned(
      left: player.position.dx - player.attributes.vision.getRange() / 2,
      top: player.position.dy - player.attributes.vision.getRange() / 2,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: player.attributes.vision.getRange(),
          height: player.attributes.vision.getRange(),
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
                          color: AppColors()
                              .getPlayerColor(player.id)
                              .withAlpha(25),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors().getPlayerColor(player.id),
                            width: 0.3,
                          ),
                        ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: player.size * 2),
                    child: EffectsUi(
                        effects: player.effects.currentEffects,
                        tempArmor: player.attributes.defense.tempArmor,
                        tempVision: player.attributes.vision.tempVision),
                  )),
              PlayerSpriteImage(
                player: player,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
