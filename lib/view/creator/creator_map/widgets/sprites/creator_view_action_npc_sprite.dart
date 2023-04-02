import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewActionNpcSprite extends StatefulWidget {
  final Npc npc;
  final MapInfo mapInfo;
  final bool beingAttacked;
  final Function() refresh;
  const CreatorViewActionNpcSprite({
    super.key,
    required this.npc,
    required this.mapInfo,
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

    _controller.checkSelected(widget.npc, user.selectedNpc);
    _controller.initializeTempPosition(widget.npc.position);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _controller.tempPosition.newPosition.dx -
              (widget.npc.vision.getRange() / 2),
          top: _controller.tempPosition.newPosition.dy -
              (widget.npc.vision.getRange() / 2),
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
                      selected: _controller.isSelected,
                      beingAttacked: widget.beingAttacked,
                      range: widget.npc.vision.getRange(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteMoveRange(
                      selected: _controller.isSelected,
                      beingAttacked: widget.beingAttacked,
                      maxRange: widget.npc.movement.maxRange(),
                      distanceMoved: _controller.tempPosition.distanceMoved,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.isSelected) {
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
                      _controller.endMove(widget.npc, widget.mapInfo);

                      widget.refresh();
                    },
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
        ));
  }
}

class NpcSpriteController {
  final TempPosition tempPosition = TempPosition();
  bool drag = false;
  bool isSelected = false;

  void checkSelected(Npc npc, Npc? selectedNpc) {
    if (selectedNpc == null) {
      isSelected = false;
      return;
    }

    if (npc.id == selectedNpc.id) {
      isSelected = true;
      return;
    }
    isSelected = false;
  }

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(Npc npc) {
    return Offset(tempPosition.newPosition.dx - npc.vision.getRange() / 2,
        tempPosition.newPosition.dy - npc.vision.getRange() / 2);
  }

  void endMove(Npc npc, MapInfo mapInfo) {
    if (tempPosition.distanceMoved < npc.movement.maxRange()) {
      tempPosition.newPosition.tile =
          mapInfo.getTile(tempPosition.newPosition.getOffset());
      npc.changePosition(tempPosition.newPosition);
    }

    drag = false;
  }
}

// ignore: must_be_immutable
class NpcSpriteMoveRange extends StatelessWidget {
  final bool selected;
  final bool beingAttacked;
  final double maxRange;
  final double distanceMoved;

  const NpcSpriteMoveRange({
    Key? key,
    required this.selected,
    required this.beingAttacked,
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
  final bool selected;
  final bool beingAttacked;
  final double range;

  const NpcSpriteVisionRange({
    Key? key,
    required this.selected,
    required this.beingAttacked,
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
        width: (selected) ? range : 0,
        height: (selected) ? range : 0,
      ),
    );
  }
}
