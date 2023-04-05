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

class CreatorViewEditNpcSprite extends StatefulWidget {
  final Npc npc;
  final bool selected;
  final Function() refresh;
  const CreatorViewEditNpcSprite({
    super.key,
    required this.npc,
    required this.selected,
    required this.refresh,
  });

  @override
  State<CreatorViewEditNpcSprite> createState() =>
      _CreatorViewEditNpcSpriteState();
}

class _CreatorViewEditNpcSpriteState extends State<CreatorViewEditNpcSprite> {
  final NpcSpriteController _controller = NpcSpriteController();

  Color getColor() {
    if (widget.selected) {
      return AppColors.uiColorLight.withAlpha(75);
    } else {
      return AppColors.uiColorDark.withAlpha(25);
    }
  }

  Color getStrokeColor() {
    if (widget.selected) {
      return AppColors.uiColorLight.withAlpha(200);
    } else {
      return AppColors.uiColorDark.withAlpha(100);
    }
  }

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
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: getColor(),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: getStrokeColor(),
                        width: 0.3,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selected) {
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

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Npc npc) {
    return Offset(
        tempPosition.newPosition.dx - npc.attributes.vision.getRange() / 2,
        tempPosition.newPosition.dy - npc.attributes.vision.getRange() / 2);
  }

  void endMove(Npc npc, MapInfo mapInfo) {
    tempPosition.newPosition.tile =
        mapInfo.getTile(tempPosition.newPosition.getOffset());
    npc.changePosition(tempPosition.newPosition);
    drag = false;
  }
}
