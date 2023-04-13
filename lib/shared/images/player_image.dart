import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/images/player_head_image.dart';
import 'package:flutter/material.dart';
import 'player_body_image.dart';

class PlayerImage extends StatelessWidget {
  final Player player;
  final double size;
  final double headMovement;
  const PlayerImage({
    super.key,
    required this.player,
    required this.size,
    required this.headMovement,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlayerBodyImage(size: size, player: player),
        PlayerHeadImage(player: player, size: size, headMovement: headMovement),
      ],
    );
  }
}
