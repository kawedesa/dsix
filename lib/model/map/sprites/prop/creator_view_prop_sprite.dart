import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/map/sprites/hit_box_sprite.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewPropSprite extends StatefulWidget {
  final Prop prop;
  final Function() fullRefresh;
  const CreatorViewPropSprite({
    super.key,
    required this.prop,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewPropSprite> createState() => _CreatorViewPropSpriteState();
}

class _CreatorViewPropSpriteState extends State<CreatorViewPropSprite> {
  final PropSpriteController _controller = PropSpriteController();
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.prop.position);
    _controller.checkSelected(user, widget.prop);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left:
              _controller.tempPosition.newPosition.dx - (widget.prop.size / 2),
          top: _controller.tempPosition.newPosition.dy - (widget.prop.size / 2),
          child: GestureDetector(
            child: SizedBox(
              width: widget.prop.size,
              height: widget.prop.size,
              child: Stack(
                children: [
                  TransparentPointer(
                    transparent: true,
                    child: SvgPicture.asset(
                      AppImages().getPropSprite(widget.prop.name,
                          widget.prop.type, _controller.isOpen(widget.prop)),
                      height: widget.prop.size,
                      width: widget.prop.size,
                    ),
                  ),
                  (widget.prop.loot.isNotEmpty &&
                          widget.prop.name == 'chest' &&
                          widget.prop.locked == false)
                      ? TransparentPointer(
                          transparent: true,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: widget.prop.size / 1.25,
                              height: widget.prop.size / 1.25,
                              child: const RiveAnimation.asset(
                                AppAnimations.loot,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  HitBoxSprite(
                    size: widget.prop.size,
                    hitBox: widget.prop.hitBox
                        .propHitBox(widget.prop.name, widget.prop.type),
                  ),
                ],
              ),
            ),
            onTap: () {
              if (_controller.selected) {
                user.deselect();
              } else {
                user.deselect();
                user.selectProp(widget.prop);
              }

              widget.fullRefresh();
            },
            onPanStart: (details) {
              _controller.drag = true;

              user.deselect();
              user.selectProp(widget.prop);
              widget.fullRefresh();
            },
            onPanUpdate: (details) {
              _controller.tempPosition.panUpdate(details.delta, false);
              localRefresh();
            },
            onPanEnd: (details) {
              _controller.endMove(_controller.tempPosition, widget.prop);
            },
          ),
        ));
  }
}

class PropSpriteController {
  //SELECTION
  bool selected = false;
  void checkSelected(User user, Prop prop) {
    selected = user.checkSelectedProp(prop.id);
  }

  //POSITION

  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Prop prop) {
    return Offset(tempPosition.newPosition.dx - prop.size / 2,
        tempPosition.newPosition.dy - prop.size / 2);
  }

  void endMove(TempPosition tempPosition, Prop prop) {
    prop.changePosition(tempPosition.newPosition);
    drag = false;
  }

  //OPEN
  bool isOpen(Prop prop) {
    bool isOpen = false;
    if (prop.lootIsEmpty()) {
      isOpen = true;
      return isOpen;
    }

    if (prop.locked) {
      isOpen = false;
      return isOpen;
    }

    if (prop.locked == false && prop.name == 'chest') {
      isOpen = true;
      return isOpen;
    }

    return isOpen;
  }
}
