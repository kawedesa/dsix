import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../../../shared/images/app_images.dart';

class CreatorViewDeadNpcSprite extends StatelessWidget {
  final Npc npc;
  const CreatorViewDeadNpcSprite({
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
        child: SizedBox(
          width: npc.size,
          height: npc.size,
          child: Stack(
            children: [
              (npc.loot.isEmpty)
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: npc.size / 1.25,
                        height: npc.size / 1.25,
                        child: const RiveAnimation.asset(
                          AppAnimations.loot,
                        ),
                      ),
                    ),
              SvgPicture.asset(
                AppImages().getDeadNpcSprite(npc.name),
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
