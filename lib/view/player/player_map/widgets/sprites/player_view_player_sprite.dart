import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/shared/app_widgets/map/ui/effects_ui.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewPlayerSprite extends StatefulWidget {
  final MapInfo mapInfo;
  final Color color;
  final Player player;
  final String playerMode;
  final Function() onTap;
  const PlayerViewPlayerSprite(
      {super.key,
      required this.mapInfo,
      required this.color,
      required this.player,
      required this.playerMode,
      required this.onTap});

  @override
  State<PlayerViewPlayerSprite> createState() => _PlayerViewPlayerSpriteState();
}

class _PlayerViewPlayerSpriteState extends State<PlayerViewPlayerSprite> {
  final PlayerSpriteController _controller = PlayerSpriteController();

  @override
  Widget build(BuildContext context) {
    _controller.initializePosition(widget.player);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
      create: (context) => _controller.tempPosition,
      update: (context, _, tempPosition) => tempPosition!..panEnd(),
      child: Positioned(
        left: _controller.getPosition(widget.player).dx,
        top: _controller.getPosition(widget.player).dy,
        child: TransparentPointer(
          transparent: true,
          child: SizedBox(
            width: widget.player.attributes.vision.getRange(),
            height: widget.player.attributes.vision.getRange(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteVisionRange(
                      range: widget.player.attributes.vision.getRange(),
                      color: widget.color),
                ),
                Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteMoveRange(
                      playerMode: widget.playerMode,
                      maxRange: widget.player.attributes.movement.maxRange(),
                      distanceMoved: _controller.tempPosition.distanceMoved,
                      color: widget.color),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: widget.player.size * 2),
                      child: EffectsUi(
                          effects: widget.player.effects.currentEffects,
                          tempArmor: widget.player.attributes.defense.tempArmor,
                          tempVision:
                              widget.player.attributes.vision.tempVision),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: widget.player.size),
                    child: SizedBox(
                        width: widget.player.size,
                        height: widget.player.size,
                        child: PlayerSpriteImage(
                          color: widget.color,
                          race: widget.player.race,
                          sex: widget.player.sex,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: TransparentPointer(
                    transparent: false,
                    child: GestureDetector(
                      onTap: () {
                        widget.onTap();
                      },
                      onPanStart: (details) {
                        _controller.drag = true;
                      },
                      onPanUpdate: (details) {
                        setState(() {
                          _controller.tempPosition.panUpdate(details.delta, '');
                        });
                      },
                      onPanEnd: (details) {
                        setState(() {
                          _controller.endMove(widget.player, widget.mapInfo);
                          _controller.drag = false;
                        });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(bottom: widget.player.size / 1.2),
                        child: Container(
                          width: widget.player.size / 4,
                          height: widget.player.size / 2,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerSpriteController {
  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializePosition(Player player) {
    if (drag == false) {
      tempPosition.initialize(player.position);
    }
  }

  Offset getPosition(Player player) {
    return Offset(
        tempPosition.newPosition.dx - player.attributes.vision.getRange() / 2,
        tempPosition.newPosition.dy - player.attributes.vision.getRange() / 2);
  }

  void endMove(Player player, MapInfo mapInfo) {
    if (tempPosition.distanceMoved < player.attributes.movement.maxRange()) {
      tempPosition.newPosition.tile =
          mapInfo.getTile(tempPosition.newPosition.getOffset());
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

      if (distanceMoved < maxRange) {
        rangeColor = rangeColor.withAlpha(25);
      }
      if (distanceMoved > maxRange) {
        rangeColor = AppColors.negative.withAlpha(200);
      }
      return rangeColor;
    }

    Color getStrokeColor() {
      Color rangeColor = color;

      if (distanceMoved < maxRange) {
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
