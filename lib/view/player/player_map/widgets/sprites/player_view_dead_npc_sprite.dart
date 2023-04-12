import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/view/player/player_map/widgets/loot_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerViewDeadNpcSprite extends StatelessWidget {
  final Npc npc;
  const PlayerViewDeadNpcSprite({
    super.key,
    required this.npc,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: npc.position.dx - (npc.size / 2),
      top: npc.position.dy - (npc.size / 2),
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          child: SvgPicture.asset(
            (npc.loot.isEmpty) ? AppImages.chestOpen : AppImages.chestClosed,
            width: 10,
            height: 10,
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return LootDialog(
                    npc: npc,
                  );
                });
          },
        ),
      ),
    );
  }
}
