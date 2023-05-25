import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/sprites/player/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewPlayerSprite extends StatelessWidget {
  final Player player;

  const CreatorViewPlayerSprite({
    super.key,
    required this.player,
  });
  Offset getPosition(Player player) {
    return Offset(player.position.dx - getSpriteSize(player) / 2,
        player.position.dy - getSpriteSize(player) / 2);
  }

  double getSpriteSize(Player player) {
    if (player.attributes.vision.getRange() < 100) {
      return 100;
    } else {
      return player.attributes.vision.getRange();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: getPosition(player).dx,
      top: getPosition(player).dy,
      child: TransparentPointer(
        transparent: true,
        child: SizedBox(
          width: getSpriteSize(player),
          height: getSpriteSize(player),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: (player.inActionArea(user.combat.actionArea.area))
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
