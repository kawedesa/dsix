import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/animation/damage_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewActionNpcSprite extends StatefulWidget {
  final Npc npc;
  final bool selected;
  final Function() selectNpc;
  final Function() deselectNpc;

  const CreatorViewActionNpcSprite({
    super.key,
    required this.npc,
    required this.selected,
    required this.selectNpc,
    required this.deselectNpc,
  });

  @override
  State<CreatorViewActionNpcSprite> createState() =>
      _CreatorViewActionNpcSpriteState();
}

class _CreatorViewActionNpcSpriteState
    extends State<CreatorViewActionNpcSprite> {
  final NpcSpriteController _controller = NpcSpriteController();
  final TempPosition _tempPosition = TempPosition();
  bool drag = false;

  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _tempPosition.initialize(widget.npc.position);
    }

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left:
              _tempPosition.newPosition.dx - (widget.npc.vision.getRange() / 2),
          top:
              _tempPosition.newPosition.dy - (widget.npc.vision.getRange() / 2),
          child: SizedBox(
            width: widget.npc.vision.getRange(),
            height: widget.npc.vision.getRange(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteVisionRange(
                      selected: widget.selected,
                      range: widget.npc.vision.getRange(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteMoveRange(
                      selected: widget.selected,
                      maxRange: widget.npc.movement.maxRange(),
                      distanceMoved: _tempPosition.distanceMoved,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.selected) {
                          widget.deselectNpc();
                        } else {
                          widget.selectNpc();
                        }
                      });
                    },
                    onPanStart: (details) {
                      drag = true;
                      widget.selectNpc();
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _tempPosition.panUpdate(details.delta, 'tile');
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _controller.endMove(_tempPosition, widget.npc);
                        drag = false;
                      });
                    },
                    child: SizedBox(
                      width: widget.npc.size,
                      height: widget.npc.size,
                      child: Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: SvgPicture.asset(
                          AppImages().getNpcIcon(
                            widget.npc.race,
                          ),
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                _controller.lifeAnimation(widget.npc),
              ],
            ),
          ),
        ));
  }
}

class NpcSpriteController {
  Offset getPosition(TempPosition tempPosition, Npc npc) {
    return Offset(tempPosition.newPosition.dx - npc.vision.getRange() / 2,
        tempPosition.newPosition.dy - npc.vision.getRange() / 2);
  }

  void endMove(TempPosition tempPosition, Npc npc) {
    if (tempPosition.distanceMoved < npc.movement.maxRange() &&
        tempPosition.distanceMoved > 4) {
      npc.changePosition(tempPosition.newPosition);
    }
  }

  int? lifeChecker;
  List<Widget> animations = [];

  Widget lifeAnimation(Npc npc) {
    lifeChecker ??= npc.life.current;

    if (lifeChecker != npc.life.current) {
      int damage = npc.life.current - lifeChecker!;

      animations.add(DamageAnimation(damage: damage));
    }
    lifeChecker = npc.life.current;

    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: npc.size * 2),
        child: Stack(
          children: animations,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NpcSpriteMoveRange extends StatelessWidget {
  final bool selected;
  final double maxRange;
  final double distanceMoved;

  const NpcSpriteMoveRange({
    Key? key,
    required this.selected,
    required this.maxRange,
    required this.distanceMoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      Color rangeColor = AppColors.uiColorDark.withAlpha(25);

      if (selected) {
        rangeColor = AppColors.uiColorLight.withAlpha(25);
      }

      if (distanceMoved > 0 && distanceMoved < 4) {
        rangeColor = AppColors.negative.withAlpha(25);
      }

      if (distanceMoved > maxRange) {
        rangeColor = AppColors.negative.withAlpha(25);
      }

      return rangeColor;
    }

    Color getStrokeColor() {
      Color rangeColor = AppColors.uiColorDark.withAlpha(100);

      if (selected) {
        rangeColor = AppColors.uiColorLight.withAlpha(200);
      }

      if (distanceMoved > 0 && distanceMoved < 4) {
        rangeColor = AppColors.negative.withAlpha(100);
      }

      if (distanceMoved > maxRange) {
        rangeColor = AppColors.negative.withAlpha(100);
      }

      return rangeColor;
    }

    double getRange() {
      double range = 0;

      switch (selected) {
        case true:
          range =
              (maxRange - distanceMoved < 10) ? 10 : maxRange - distanceMoved;
          break;
        case false:
          range = 10;
          break;
      }

      return range;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 700),
      width: getRange(),
      height: getRange(),
      decoration: BoxDecoration(
        color: getColor(),
        shape: BoxShape.circle,
        border: Border.all(
          color: getStrokeColor(),
          width: 0.3,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NpcSpriteVisionRange extends StatelessWidget {
  final double range;
  final bool selected;
  const NpcSpriteVisionRange({
    Key? key,
    required this.range,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [3, 6],
      color: (selected)
          ? AppColors.uiColorLight.withAlpha(200)
          : Colors.transparent,
      strokeWidth: 0.3,
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 700),
        width: (selected) ? range : 0,
        height: (selected) ? range : 0,
      ),
    );
  }
}
