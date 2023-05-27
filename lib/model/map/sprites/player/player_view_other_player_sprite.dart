import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/sprites/player/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewOtherPlayerSprite extends StatelessWidget {
  final Player player;
  final ValueNotifier<Path> actionArea;

  const PlayerViewOtherPlayerSprite(
      {super.key, required this.player, required this.actionArea});
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
                child: ValueListenableBuilder<Path>(
                  valueListenable: actionArea,
                  builder: (context, position, child) {
                    return Container(
                      width: 7,
                      height: 7,
                      decoration: (player.inActionArea(actionArea.value))
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
                    );
                  },
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
