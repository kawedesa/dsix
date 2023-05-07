import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorViewChestSprite extends StatefulWidget {
  final Chest chest;
  final Function() fullRefresh;
  const CreatorViewChestSprite({
    super.key,
    required this.chest,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewChestSprite> createState() => _CreatorViewChestSpriteState();
}

class _CreatorViewChestSpriteState extends State<CreatorViewChestSprite> {
  final ChestSpriteController _controller = ChestSpriteController();
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.chest.position);
    _controller.checkSelected(user, widget.chest);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left:
              _controller.tempPosition.newPosition.dx - (widget.chest.size / 2),
          top:
              _controller.tempPosition.newPosition.dy - (widget.chest.size / 2),
          child: SizedBox(
            height: widget.chest.size,
            width: widget.chest.size,
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
                        user.selectChest(widget.chest);
                      }

                      widget.fullRefresh();
                    },
                    onPanStart: (details) {
                      _controller.drag = true;

                      user.deselect();
                      user.selectChest(widget.chest);
                      widget.fullRefresh();
                    },
                    onPanUpdate: (details) {
                      _controller.tempPosition.panUpdate(details.delta, false);
                      localRefresh();
                    },
                    onPanEnd: (details) {
                      _controller.endMove(
                          _controller.tempPosition, widget.chest);
                    },
                    child: SvgPicture.asset(
                      AppImages().getChestSprite(
                          widget.chest.name, widget.chest.lootIsEmpty()),
                      height: widget.chest.size,
                      width: widget.chest.size,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class ChestSpriteController {
  //SELECTION
  bool selected = false;
  void checkSelected(User user, Chest chest) {
    selected = user.checkSelectedChest(chest.id);
  }

  //POSITION

  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Chest chest) {
    return Offset(tempPosition.newPosition.dx - chest.size / 2,
        tempPosition.newPosition.dy - chest.size / 2);
  }

  void endMove(TempPosition tempPosition, Chest chest) {
    chest.changePosition(tempPosition.newPosition);
    drag = false;
  }
}
