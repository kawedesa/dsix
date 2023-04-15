import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/map/sprites/npc/npc_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewEditNpcSprite extends StatefulWidget {
  final Npc npc;
  final Function() fullRefresh;
  const CreatorViewEditNpcSprite({
    super.key,
    required this.npc,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewEditNpcSprite> createState() =>
      _CreatorViewEditNpcSpriteState();
}

class _CreatorViewEditNpcSpriteState extends State<CreatorViewEditNpcSprite> {
  final NpcSpriteController _controller = NpcSpriteController();

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.npc.position);
    _controller.checkSelected(user, widget.npc);

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
                    child: NpcSpriteMoveRange(
                      selected: _controller.selected,
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
                    _controller.drag = true;
                    user.deselect();
                    user.selectNpc(widget.npc);
                    widget.fullRefresh();
                  },
                  onPanUpdate: (details) {
                    _controller.tempPosition.panUpdate(details.delta, 'tile');
                    localRefresh();
                  },
                  onPanEnd: (details) {
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
//SELECTION
  bool selected = false;
  void checkSelected(User user, Npc npc) {
    selected = user.checkSelectedNpc(npc.id);
  }

  //POSITION

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

class NpcSpriteMoveRange extends StatelessWidget {
  final bool selected;

  const NpcSpriteMoveRange({
    Key? key,
    required this.selected,
  }) : super(key: key);

  Color getColor() {
    Color rangeColor = AppColors.uiColorDark.withAlpha(25);

    if (selected) {
      rangeColor = AppColors.uiColorLight.withAlpha(25);
    }

    return rangeColor;
  }

  Color getStrokeColor() {
    Color rangeColor = AppColors.uiColorDark.withAlpha(100);

    if (selected) {
      rangeColor = AppColors.uiColorLight.withAlpha(200);
    }

    return rangeColor;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 700),
      width: 7,
      height: 7,
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
