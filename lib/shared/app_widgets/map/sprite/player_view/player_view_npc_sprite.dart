import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/animation/damage_animation.dart';
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
  int? lifeChecker;
  List<Widget> animations = [];

  Widget lifeAnimation() {
    lifeChecker ??= widget.npc.life.current;

    if (lifeChecker != widget.npc.life.current) {
      int damage = widget.npc.life.current - lifeChecker!;

      animations.add(DamageAnimation(damage: damage));
    }
    lifeChecker = widget.npc.life.current;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.npc.size * 2),
        child: Stack(
          children: animations,
        ),
      ),
    );
  }

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
                decoration: BoxDecoration(
                  color: AppColors.uiColorDark.withAlpha(25),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.uiColorDark.withAlpha(25),
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
                      AppImages().getRaceIcon(
                        widget.npc.race,
                      ),
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            lifeAnimation(),
          ],
        ),
      ),
    );
  }
}
