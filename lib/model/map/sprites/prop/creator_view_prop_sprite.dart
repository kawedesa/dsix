import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
          child: SizedBox(
            height: widget.prop.size,
            width: widget.prop.size,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
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
                      _controller.endMove(
                          _controller.tempPosition, widget.prop);
                    },
                    child: SvgPicture.asset(
                      AppImages().getPropSprite(widget.prop.name,
                          widget.prop.type, widget.prop.lootIsEmpty()),
                      height: widget.prop.size,
                      width: widget.prop.size,
                    ),
                  ),
                ),
              ],
            ),
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
}
