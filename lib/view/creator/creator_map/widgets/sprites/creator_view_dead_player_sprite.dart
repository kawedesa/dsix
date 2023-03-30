import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewDeadPlayerSprite extends StatefulWidget {
  final Player player;
  final Color color;

  const CreatorViewDeadPlayerSprite({
    super.key,
    required this.player,
    required this.color,
  });

  @override
  State<CreatorViewDeadPlayerSprite> createState() =>
      _CreatorViewDeadPlayerSpriteState();
}

class _CreatorViewDeadPlayerSpriteState
    extends State<CreatorViewDeadPlayerSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: widget.player.position.dx - widget.player.size / 2,
        top: widget.player.position.dy - widget.player.size,
        child: TransparentPointer(
          transparent: true,
          child: SizedBox(
            width: widget.player.size,
            height: widget.player.size,
            child: Stack(
              children: [
                SvgPicture.asset(
                  AppImages.grave,
                  width: AppLayout.shortest(context) * 0.5,
                ),
                SvgPicture.asset(
                  AppImages.graveColor,
                  color: widget.color,
                  width: AppLayout.shortest(context) * 0.5,
                ),
              ],
            ),
          ),
        ));
  }
}
