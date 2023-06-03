import 'package:dsix/shared/images/player_head_image.dart';
import 'package:flutter/material.dart';
import 'player_body_image.dart';

class PlayerImage extends StatelessWidget {
  final String race;
  final String sex;
  final double size;
  final double headMovement;
  final Color color;
  const PlayerImage({
    super.key,
    required this.race,
    required this.sex,
    required this.size,
    required this.headMovement,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlayerBodyImage(
          race: race,
          sex: sex,
          size: size,
        ),
        PlayerBodyImage(
          race: race,
          sex: sex,
          size: size,
          color: color,
        ),
        PlayerHeadImage(
          race: race,
          sex: sex,
          size: size,
          headMovement: headMovement,
        ),
        PlayerHeadImage(
          race: race,
          sex: sex,
          size: size,
          headMovement: headMovement,
          color: color,
        ),
      ],
    );
  }
}
