import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/shared/app_widgets/map/ui/effects_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewActionNpcSprite extends StatefulWidget {
  final Npc npc;
  final bool selected;
  final bool beingAttacked;
  final Function() refresh;

  const CreatorViewActionNpcSprite({
    super.key,
    required this.npc,
    required this.selected,
    required this.beingAttacked,
    required this.refresh,
  });

  @override
  State<CreatorViewActionNpcSprite> createState() =>
      _CreatorViewActionNpcSpriteState();
}

class _CreatorViewActionNpcSpriteState
    extends State<CreatorViewActionNpcSprite> {
  final NpcSpriteController _controller = NpcSpriteController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.npc.position);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _controller.tempPosition.newPosition.dx -
              (widget.npc.attributes.vision.getRange() / 2),
          top: _controller.tempPosition.newPosition.dy -
              (widget.npc.attributes.vision.getRange() / 2),
          child: SizedBox(
            width: widget.npc.attributes.vision.getRange(),
            height: widget.npc.attributes.vision.getRange(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteVisionRange(
                      selected: widget.selected,
                      beingAttacked: widget.beingAttacked,
                      npcMode: user.npcMode,
                      range: widget.npc.attributes.vision.getRange(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteMoveRange(
                      selected: widget.selected,
                      beingAttacked: widget.beingAttacked,
                      npcMode: user.npcMode,
                      maxRange: widget.npc.attributes.movement.maxRange(),
                      distanceMoved: _controller.tempPosition.distanceMoved,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: widget.npc.size * 1.75),
                      child: TransparentPointer(
                        transparent: true,
                        child: EffectsUi(
                            effects: widget.npc.effects.currentEffects,
                            tempArmor: widget.npc.attributes.defense.tempArmor,
                            tempVision:
                                widget.npc.attributes.vision.tempVision),
                      ),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.npc.size),
                    child: TransparentPointer(
                      transparent: true,
                      child: SvgPicture.asset(
                        AppImages().getNpcIcon(
                          widget.npc.name,
                        ),
                        width: widget.npc.size,
                        height: widget.npc.size,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: (user.npcMode == 'wait')
                      ? GestureDetector(
                          onTap: () {
                            if (user.checkSelectedNpc(widget.npc.id)) {
                              user.deselect();
                            } else {
                              user.deselect();
                              user.selectNpc(widget.npc);
                            }
                            widget.refresh();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: widget.npc.size / 2),
                            child: Container(
                              width: widget.npc.size / 2,
                              height: widget.npc.size / 2,
                              color: Colors.transparent,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            if (user.checkSelectedNpc(widget.npc.id)) {
                              user.deselect();
                            } else {
                              user.deselect();
                              user.selectNpc(widget.npc);
                            }
                            widget.refresh();
                          },
                          onPanStart: (details) {
                            _controller.drag = true;
                            user.selectNpc(widget.npc);
                            widget.refresh();
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              _controller.tempPosition
                                  .panUpdate(details.delta, 'tile');
                            });
                          },
                          onPanEnd: (details) {
                            _controller.endMove(widget.npc, user.mapInfo);

                            widget.refresh();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: widget.npc.size / 2),
                            child: Container(
                              width: widget.npc.size / 2,
                              height: widget.npc.size / 2,
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}

class NpcSpriteController {
  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(Npc npc) {
    return Offset(
        tempPosition.newPosition.dx - npc.attributes.vision.getRange() / 2,
        tempPosition.newPosition.dy - npc.attributes.vision.getRange() / 2);
  }

  void endMove(Npc npc, MapInfo mapInfo) {
    if (tempPosition.distanceMoved < npc.attributes.movement.maxRange()) {
      tempPosition.newPosition.tile =
          mapInfo.getTile(tempPosition.newPosition.getOffset());
      npc.changePosition(tempPosition.newPosition);
    }

    drag = false;
  }
}

class NpcSpriteMoveRange extends StatelessWidget {
  final bool selected;
  final bool beingAttacked;
  final String npcMode;
  final double maxRange;
  final double distanceMoved;

  const NpcSpriteMoveRange({
    Key? key,
    required this.selected,
    required this.beingAttacked,
    required this.npcMode,
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

      if (distanceMoved > maxRange) {
        rangeColor = AppColors.cancel.withAlpha(200);
      }

      if (beingAttacked) {
        rangeColor = AppColors.cancel.withAlpha(200);
      }

      return rangeColor;
    }

    Color getStrokeColor() {
      Color rangeColor = AppColors.uiColorDark.withAlpha(100);

      if (selected) {
        rangeColor = AppColors.uiColorLight.withAlpha(200);
      }

      if (distanceMoved > maxRange) {
        rangeColor = AppColors.cancel;
      }

      if (beingAttacked) {
        rangeColor = AppColors.cancel;
      }

      return rangeColor;
    }

    double getRange() {
      double range = 0;

      if (selected) {
        range = (maxRange - distanceMoved < 7) ? 7 : maxRange - distanceMoved;
      } else {
        range = 7;
      }

      if (npcMode == 'wait') {
        range = 7;
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

class NpcSpriteVisionRange extends StatelessWidget {
  final bool selected;
  final bool beingAttacked;
  final String npcMode;
  final double range;

  const NpcSpriteVisionRange({
    Key? key,
    required this.selected,
    required this.beingAttacked,
    required this.npcMode,
    required this.range,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [3, 6],
      color: (beingAttacked)
          ? AppColors.cancel.withAlpha(200)
          : (selected)
              ? AppColors.uiColorLight.withAlpha(200)
              : Colors.transparent,
      strokeWidth: 0.3,
      child: AnimatedContainer(
        curve: Curves.fastLinearToSlowEaseIn,
        duration: const Duration(milliseconds: 700),
        width: (selected && npcMode != 'wait') ? range : 0,
        height: (selected && npcMode != 'wait') ? range : 0,
      ),
    );
  }
}
