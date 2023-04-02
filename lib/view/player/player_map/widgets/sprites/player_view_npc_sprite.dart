import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerViewNpcSprite extends StatefulWidget {
  final Npc npc;
  final bool beingAttacked;
  final Function() onTap;

  const PlayerViewNpcSprite({
    super.key,
    required this.npc,
    required this.beingAttacked,
    required this.onTap,
  });

  @override
  State<PlayerViewNpcSprite> createState() => _PlayerViewNpcSpriteState();
}

class _PlayerViewNpcSpriteState extends State<PlayerViewNpcSprite> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.npc.position.dx - widget.npc.vision.getRange() / 2,
      top: widget.npc.position.dy - widget.npc.vision.getRange() / 2,
      child: SizedBox(
        width: widget.npc.vision.getRange(),
        height: widget.npc.vision.getRange(),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 7,
                height: 7,
                decoration: (widget.beingAttacked)
                    ? BoxDecoration(
                        color: AppColors.cancel.withAlpha(200),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.cancel,
                          width: 0.3,
                        ),
                      )
                    : BoxDecoration(
                        color: AppColors.uiColor.withAlpha(25),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.uiColor,
                          width: 0.3,
                        ),
                      ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {},
                onPanStart: (details) {},
                onPanUpdate: (details) {},
                onPanEnd: (details) {},
                child: SizedBox(
                  width: widget.npc.size,
                  height: widget.npc.size,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: SvgPicture.asset(
                      AppImages().getNpcIcon(
                        widget.npc.name,
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
