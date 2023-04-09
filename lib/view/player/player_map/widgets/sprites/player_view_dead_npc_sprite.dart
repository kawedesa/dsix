import 'package:dsix/model/npc/npc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/app_images.dart';

class PlayerViewDeadNpcSprite extends StatefulWidget {
  final Npc npc;
  final Function() onTap;
  const PlayerViewDeadNpcSprite({
    super.key,
    required this.npc,
    required this.onTap,
  });

  @override
  State<PlayerViewDeadNpcSprite> createState() =>
      _PlayerViewDeadNpcSpriteState();
}

class _PlayerViewDeadNpcSpriteState extends State<PlayerViewDeadNpcSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.npc.position.dx - (widget.npc.size / 2),
      top: widget.npc.position.dy - (widget.npc.size / 2),
      child: SizedBox(
        width: 10,
        height: 10,
        child: Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            child: SvgPicture.asset(
              (widget.npc.loot.isEmpty)
                  ? AppImages.chestOpen
                  : AppImages.chestClosed,
            ),
            onTap: () {
              widget.onTap();
            },
          ),
        ),
      ),
    );
  }
}
