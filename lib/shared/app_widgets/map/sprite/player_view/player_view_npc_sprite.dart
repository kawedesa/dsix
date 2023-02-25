import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerViewNpcSprite extends StatefulWidget {
  final Npc npc;
  final Function() onTap;

  const PlayerViewNpcSprite({
    super.key,
    required this.npc,
    required this.onTap,
  });

  @override
  State<PlayerViewNpcSprite> createState() => _PlayerViewNpcSpriteState();
}

class _PlayerViewNpcSpriteState extends State<PlayerViewNpcSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.npc.position.dx - widget.npc.size / 2,
      top: widget.npc.position.dy - widget.npc.size / 2,
      child: Container(
        width: widget.npc.size,
        height: widget.npc.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withAlpha(100),
          border: Border.all(
            color: Colors.red,
            width: 1,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            widget.onTap();
          },
          child: SvgPicture.asset(
            AppImages().getRaceIcon(
              widget.npc.race,
            ),
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
