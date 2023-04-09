import 'package:dsix/model/npc/npc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../shared/app_images.dart';

class CreatorViewDeadNpcSprite extends StatefulWidget {
  final Npc npc;
  const CreatorViewDeadNpcSprite({
    super.key,
    required this.npc,
  });

  @override
  State<CreatorViewDeadNpcSprite> createState() =>
      _CreatorViewDeadNpcSpriteState();
}

class _CreatorViewDeadNpcSpriteState extends State<CreatorViewDeadNpcSprite> {
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
          child: SvgPicture.asset(
            (widget.npc.loot.isEmpty)
                ? AppImages.chestOpen
                : AppImages.chestClosed,
          ),
        ),
      ),
    );
  }
}
