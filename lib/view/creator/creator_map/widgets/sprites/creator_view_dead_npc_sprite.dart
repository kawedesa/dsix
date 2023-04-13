import 'package:dsix/model/npc/npc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/images/app_images.dart';

class CreatorViewDeadNpcSprite extends StatelessWidget {
  final Npc npc;
  const CreatorViewDeadNpcSprite({
    super.key,
    required this.npc,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: npc.position.dx - 5,
      top: npc.position.dy - 10,
      child: SizedBox(
        width: 10,
        height: 10,
        child: Align(
          alignment: Alignment.topCenter,
          child: SvgPicture.asset(
            (npc.loot.isEmpty) ? AppImages.chestOpen : AppImages.chestClosed,
          ),
        ),
      ),
    );
  }
}
