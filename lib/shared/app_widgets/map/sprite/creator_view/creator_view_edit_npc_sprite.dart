import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorViewEditNpcSprite extends StatefulWidget {
  final Npc npc;
  final bool selected;
  final Function() selectNpc;

  const CreatorViewEditNpcSprite({
    super.key,
    required this.npc,
    required this.selected,
    required this.selectNpc,
  });

  @override
  State<CreatorViewEditNpcSprite> createState() =>
      _CreatorViewEditNpcSpriteState();
}

class _CreatorViewEditNpcSpriteState extends State<CreatorViewEditNpcSprite> {
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
                    onTap: () {
                      widget.selectNpc();
                    },
                    onPanStart: (details) {
                      drag = true;
                      widget.selectNpc();
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        _tempPosition.panUpdate(details.delta);
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
                          AppImages().getRaceIcon(
                            widget.npc.race,
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
  Offset getPosition(TempPosition tempPosition, Npc npc) {
    return Offset(tempPosition.newPosition.dx - npc.vision.getRange() / 2,
        tempPosition.newPosition.dy - npc.vision.getRange() / 2);
  }

  void endMove(TempPosition tempPosition, Npc npc) {
    npc.changePosition(tempPosition.newPosition);
  }
}
