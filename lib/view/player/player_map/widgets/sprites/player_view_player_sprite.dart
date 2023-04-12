import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/shared/app_widgets/map/ui/effects_ui.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewPlayerSprite extends StatefulWidget {
  const PlayerViewPlayerSprite({
    super.key,
  });

  @override
  State<PlayerViewPlayerSprite> createState() => _PlayerViewPlayerSpriteState();
}

class _PlayerViewPlayerSpriteState extends State<PlayerViewPlayerSprite> {
  final PlayerSpriteController _controller = PlayerSpriteController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializePosition(user.player);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
      create: (context) => _controller.tempPosition,
      update: (context, _, tempPosition) => tempPosition!..panEnd(),
      child: Positioned(
        left: _controller.getPosition(user.player).dx,
        top: _controller.getPosition(user.player).dy,
        child: TransparentPointer(
          transparent: true,
          child: SizedBox(
            width: user.player.attributes.vision.getRange(),
            height: user.player.attributes.vision.getRange(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteVisionRange(
                      range: user.player.attributes.vision.getRange(),
                      color: user.color),
                ),
                Align(
                  alignment: Alignment.center,
                  child: PlayerSpriteMoveRange(
                      playerMode: user.playerMode,
                      beingAttacked: _controller.checkBeingAttacked(user),
                      maxRange: user.player.attributes.movement.maxRange(),
                      distanceMoved: _controller.tempPosition.distanceMoved,
                      color: user.color),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: user.player.size * 2),
                      child: EffectsUi(
                          effects: user.player.effects.currentEffects,
                          tempArmor: user.player.attributes.defense.tempArmor,
                          tempVision: user.player.attributes.vision.tempVision),
                    )),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: user.player.size),
                    child: SizedBox(
                        width: user.player.size,
                        height: user.player.size,
                        child: PlayerSpriteImage(
                          color: user.color,
                          race: user.player.race,
                          sex: user.player.sex,
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: (user.playerMode == 'wait')
                      ? const SizedBox()
                      : GestureDetector(
                          onPanStart: (details) {
                            _controller.drag = true;
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              _controller.tempPosition
                                  .panUpdate(details.delta, '');
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              _controller.endMove(user.player, user.mapInfo);
                              _controller.drag = false;
                            });
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: user.player.size / 1.2),
                            child: Container(
                              width: user.player.size / 4,
                              height: user.player.size / 2,
                              color: Colors.transparent,
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
  //BEING ATTACKED
  bool checkBeingAttacked(User user) {
    if (user.combat.actionArea.area
        .contains(user.player.position.getOffset())) {
      return true;
    } else {
      return false;
    }
  }

  //POSITION
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

class PlayerSpriteMoveRange extends StatelessWidget {
  final String playerMode;
  final double maxRange;
  final double distanceMoved;
  final bool beingAttacked;
  final Color color;
  const PlayerSpriteMoveRange({
    Key? key,
    required this.playerMode,
    required this.maxRange,
    required this.distanceMoved,
    required this.beingAttacked,
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

      if (beingAttacked) {
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

      if (beingAttacked) {
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
        case 'wait':
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
