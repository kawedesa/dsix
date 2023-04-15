import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewDeadPlayerSprite extends StatelessWidget {
  final Player player;

  const PlayerViewDeadPlayerSprite({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: player.position.dx - player.size / 2,
        top: player.position.dy - player.size,
        child: TransparentPointer(
          transparent: true,
          child: SizedBox(
              width: player.size,
              height: player.size,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    AppImages.grave,
                    width: AppLayout.shortest(context) * 0.5,
                  ),
                  SvgPicture.asset(
                    AppImages.graveColor,
                    color: AppColors().getPlayerColor(player.id),
                    width: AppLayout.shortest(context) * 0.5,
                  ),
                ],
              )),
        ));
  }
}
