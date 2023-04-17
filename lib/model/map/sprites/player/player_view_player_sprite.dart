import 'package:dotted_border/dotted_border.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/model/map/map_info.dart';
import 'package:dsix/model/map/sprites/player/player_sprite_image.dart';
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
                      beingAttacked: _controller.inActionArea(user),
                      maxRange: user.player.attributes.movement.maxRange(),
                      distanceMoved: _controller.tempPosition.distanceMoved,
                      color: user.color),
                ),
                GestureDetector(
                  onPanStart: (details) {
                    if (user.playerMode == 'wait') {
                      return;
                    }

                    _controller.drag = true;
                  },
                  onPanUpdate: (details) {
                    if (user.playerMode == 'wait') {
                      return;
                    }
                    setState(() {
                      _controller.tempPosition.panUpdate(details.delta, '');
                    });
                  },
                  onPanEnd: (details) {
                    if (user.playerMode == 'wait') {
                      return;
                    }
                    setState(() {
                      _controller.endMove(user.player, user.mapInfo);
                      _controller.drag = false;
                    });
                  },
                  child: PlayerSpriteImage(
                    player: user.player,
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
  bool inActionArea(User user) {
    if (user.playerMode == 'action') {
      return false;
    }

    if (user.player.inActionArea(user.combat.actionArea.area)) {
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
