import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewPlayerSprite extends StatefulWidget {
  final Color color;
  final Player player;
  final String playerMode;
  final Function() onTap;
  const PlayerViewPlayerSprite(
      {super.key,
      required this.color,
      required this.player,
      required this.playerMode,
      required this.onTap});

  @override
  State<PlayerViewPlayerSprite> createState() => _PlayerViewPlayerSpriteState();
}

class _PlayerViewPlayerSpriteState extends State<PlayerViewPlayerSprite> {
  final PlayerSpriteController _controller = PlayerSpriteController();
  final TempPosition _tempPosition = TempPosition();
  bool drag = false;

  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _tempPosition.initialize(widget.player.position);
    }

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
      create: (context) => _tempPosition,
      update: (context, _, tempPosition) => tempPosition!..panEnd(),
      child: Positioned(
        left: _controller.getPosition(_tempPosition, widget.player).dx,
        top: _controller.getPosition(_tempPosition, widget.player).dy,
        child: SizedBox(
          width: widget.player.attributes.vision.getRange(),
          height: widget.player.attributes.vision.getRange(),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: PlayerSpriteVisionRange(
                      range: widget.player.attributes.vision.getRange(),
                      color: widget.color),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TransparentPointer(
                  transparent: true,
                  child: PlayerSpriteMoveRange(
                      playerMode: widget.playerMode,
                      maxRange: widget.player.attributes.movement.maxRange(),
                      distanceMoved: _tempPosition.distanceMoved,
                      color: widget.color),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    widget.onTap();
                  },
                  onPanStart: (details) {
                    drag = true;
                  },
                  onPanUpdate: (details) {
                    setState(() {
                      _tempPosition.panUpdate(details.delta);
                    });
                  },
                  onPanEnd: (details) {
                    setState(() {
                      _controller.endMove(_tempPosition, widget.player);

                      drag = false;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.player.size),
                    child: SizedBox(
                        width: widget.player.size,
                        height: widget.player.size,
                        child: PlayerSpriteImage(
                            isDead: widget.player.life.isDead(),
                            color: widget.color,
                            race: widget.player.race)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerSpriteController {
  Offset getPosition(TempPosition tempPosition, Player player) {
    return Offset(
        tempPosition.newPosition.dx - player.attributes.vision.getRange() / 2,
        tempPosition.newPosition.dy - player.attributes.vision.getRange() / 2);
  }

  void endMove(TempPosition tempPosition, Player player) {
    if (tempPosition.distanceMoved < player.attributes.movement.maxRange() &&
        tempPosition.distanceMoved > 4) {
      player.changePosition(tempPosition.newPosition);
    }
  }
}

// ignore: must_be_immutable
class PlayerSpriteMoveRange extends StatelessWidget {
  final String playerMode;
  final double maxRange;
  final double distanceMoved;
  final Color color;
  const PlayerSpriteMoveRange({
    Key? key,
    required this.playerMode,
    required this.maxRange,
    required this.distanceMoved,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      Color rangeColor = color;

      if (distanceMoved == 0) {
        rangeColor = color;
      }
      if (distanceMoved > 0 && distanceMoved < 4) {
        rangeColor = AppColors.negative;
      }
      if (distanceMoved > 4 && distanceMoved < maxRange) {
        rangeColor = rangeColor;
      }
      if (distanceMoved > maxRange) {
        rangeColor = AppColors.negative;
      }
      return rangeColor;
    }

    double getRange() {
      double range = 0;

      switch (playerMode) {
        case 'stand':
          range = (maxRange - distanceMoved < 7) ? 7 : maxRange - distanceMoved;
          break;
        case 'menu':
          range = 7;
          break;
        case 'attack':
          range = 7;
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
        color: getColor().withAlpha(25),
        shape: BoxShape.circle,
        border: Border.all(
          color: getColor(),
          width: 0.3,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteVisionRange extends StatelessWidget {
  final double range;
  final Color color;
  const PlayerSpriteVisionRange({
    Key? key,
    required this.range,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Circle,
      dashPattern: const [3, 6],
      color: color,
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
