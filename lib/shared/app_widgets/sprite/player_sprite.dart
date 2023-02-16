import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/sprite/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/player/player.dart';

class PlayerSprite extends StatefulWidget {
  final Player player;
  final Function() onTap;
  const PlayerSprite({super.key, required this.player, required this.onTap});

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  final AppTempPosition _tempPosition = AppTempPosition();
  bool drag = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (drag == false) {
      _tempPosition.initialize(widget.player.position);
    }

    return ChangeNotifierProxyProvider<Spawner, AppTempPosition>(
      create: (context) => _tempPosition,
      update: (context, _, tempPosition) => tempPosition!..panEnd(),
      child: Positioned(
        left: _tempPosition.newPosition!.dx -
            (widget.player.attributes.vision.getRange() / 2),
        top: _tempPosition.newPosition!.dy -
            (widget.player.attributes.vision.getRange() / 2),
        child: SizedBox(
          width: widget.player.attributes.vision.getRange(),
          height: widget.player.attributes.vision.getRange(),
          child: Stack(
            children: [
              PlayerSpriteVisionRange(
                  range: widget.player.attributes.vision.getRange(),
                  color: user.color),
              Align(
                alignment: Alignment.center,
                child: PlayerSpriteMoveRange(
                    maxRange: widget.player.attributes.move.maxRange(),
                    distanceMoved: _tempPosition.distanceMoved,
                    color: user.color),
              ),
              Align(
                alignment: const Alignment(0.0, -0.15),
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
                      if (_tempPosition.distanceMoved <
                              widget.player.attributes.move.maxRange() &&
                          _tempPosition.distanceMoved > 3) {
                        widget.player
                            .changePosition(_tempPosition.newPosition!);
                      }

                      drag = false;
                    });
                  },
                  child: SizedBox(
                      width: widget.player.size,
                      height: widget.player.size,
                      child: PlayerSpriteImage(race: widget.player.race)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PlayerSpriteMoveRange extends StatelessWidget {
  final double maxRange;
  final double distanceMoved;
  final Color color;
  const PlayerSpriteMoveRange({
    Key? key,
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
      if (distanceMoved > 0 && distanceMoved < 3) {
        rangeColor = AppColors.negative;
      }
      if (distanceMoved > 3 && distanceMoved < maxRange) {
        rangeColor = rangeColor;
      }
      if (distanceMoved > maxRange) {
        rangeColor = AppColors.negative;
      }
      return rangeColor;
    }

    return AnimatedContainer(
      curve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(milliseconds: 700),
      width: (maxRange - distanceMoved < 3) ? 3 : maxRange - distanceMoved,
      height: (maxRange - distanceMoved < 3) ? 3 : maxRange - distanceMoved,
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
      dashPattern: const [3, 2],
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
