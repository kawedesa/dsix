import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerBodyImage extends StatelessWidget {
  final double size;
  final Player player;
  const PlayerBodyImage({super.key, required this.size, required this.player});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages().getPlayerBodySprite(player.race, player.sex),
      width: size,
      height: size,
    );
  }
}
