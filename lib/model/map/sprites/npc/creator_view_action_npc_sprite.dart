import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/map/sprites/aura_sprite.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/map/sprites/npc/npc_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewActionNpcSprite extends StatefulWidget {
  final Npc npc;
  final ValueNotifier<Path> actionArea;
  final Function() fullRefresh;
  const CreatorViewActionNpcSprite({
    super.key,
    required this.npc,
    required this.actionArea,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewActionNpcSprite> createState() =>
      _CreatorViewActionNpcSpriteState();
}

class _CreatorViewActionNpcSpriteState
    extends State<CreatorViewActionNpcSprite> {
  final NpcSpriteController _controller = NpcSpriteController();

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.npc.position);
    _controller.checkSelected(user, widget.npc);

    return ChangeNotifierProxyProvider<dynamic, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _controller.getPosition(widget.npc).dx,
          top: _controller.getPosition(widget.npc).dy,
          child: SizedBox(
            width: _controller.getSpriteSize(widget.npc),
            height: _controller.getSpriteSize(widget.npc),
            child: Stack(
              children: [
                AuraSprite(auras: widget.npc.effects.auras),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: NpcSpriteVisionRange(
                      selected: _controller.selected,
                      npcMode: user.npcMode,
                      range: widget.npc.attributes.vision.getRange(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: true,
                    child: ValueListenableBuilder<Path>(
                      valueListenable: widget.actionArea,
                      builder: (context, position, child) {
                        return NpcSpriteMoveRange(
                          selected: _controller.selected,
                          inAttackArea:
                              widget.npc.inActionArea(widget.actionArea.value),
                          npcMode: user.npcMode,
                          maxRange: widget.npc.attributes.movement.maxRange(),
                          distanceMoved: _controller.tempPosition.distanceMoved,
                        );
                      },
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (_controller.selected) {
                      user.deselect();
                    } else {
                      user.deselect();
                      user.selectNpc(widget.npc);
                    }
                    widget.fullRefresh();
                  },
                  onPanStart: (details) {
                    if (user.npcMode == 'wait') {
                      return;
                    }

                    _controller.drag = true;
                    user.deselect();
                    user.selectNpc(widget.npc);
                    widget.fullRefresh();
                  },
                  onPanUpdate: (details) {
                    if (user.npcMode == 'wait') {
                      return;
                    }
                    _controller.tempPosition.panUpdate(details.delta, false);

                    localRefresh();
                  },
                  onPanEnd: (details) {
                    if (user.npcMode == 'wait') {
                      return;
                    }
                    _controller.endMove(widget.npc, user.mapInfo);
                    localRefresh();
                  },
                  child: NpcSpriteImage(npc: widget.npc),
                ),
              ],
            ),
          ),
        ));
  }
}

class NpcSpriteController {
  bool selected = false;
  void checkSelected(User user, Npc npc) {
    selected = user.checkSelectedNpc(npc.id);
  }

  //WALK

  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(Npc npc) {
    return Offset(tempPosition.newPosition.dx - getSpriteSize(npc) / 2,
        tempPosition.newPosition.dy - getSpriteSize(npc) / 2);
  }

  double getSpriteSize(Npc npc) {
    if (npc.attributes.vision.getRange() < 100) {
      return 100;
    } else {
      return npc.attributes.vision.getRange();
    }
  }

  void endMove(Npc npc, MapInfo mapInfo) {
    if (tempPosition.distanceMoved < npc.attributes.movement.maxRange()) {
      tempPosition.newPosition.inGrass =
          mapInfo.inGrass(tempPosition.newPosition.getOffset());
      npc.changePosition(tempPosition.newPosition);
      npc.update();
    }
    drag = false;
  }
}

class NpcSpriteMoveRange extends StatelessWidget {
  final bool selected;
  final bool inAttackArea;
  final String npcMode;
  final double maxRange;
  final double distanceMoved;

  const NpcSpriteMoveRange({
    Key? key,
    required this.selected,
    required this.inAttackArea,
    required this.npcMode,
    required this.maxRange,
    required this.distanceMoved,
  }) : super(key: key);

  Color getColor() {
    Color rangeColor = AppColors.uiColorDark.withAlpha(25);

    if (selected) {
      rangeColor = AppColors.uiColorLight.withAlpha(25);
    }

    if (distanceMoved > maxRange) {
      rangeColor = AppColors.cancel.withAlpha(200);
    }

    if (inAttackArea) {
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

    if (inAttackArea) {
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

    if (npcMode == 'action') {
      range = 7;
    }

    return range;
  }

  @override
  Widget build(BuildContext context) {
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
  final String npcMode;
  final double range;

  const NpcSpriteVisionRange({
    Key? key,
    required this.selected,
    required this.npcMode,
    required this.range,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (npcMode == 'wait' || selected == false)
        ? const SizedBox()
        : DottedBorder(
            borderType: BorderType.Circle,
            dashPattern: const [3, 6],
            color: (selected)
                ? AppColors.uiColorLight.withAlpha(200)
                : Colors.transparent,
            strokeWidth: 0.3,
            child: AnimatedContainer(
              curve: Curves.fastLinearToSlowEaseIn,
              duration: const Duration(milliseconds: 700),
              width: range,
              height: range,
            ),
          );
  }
}
