import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../app_images.dart';
import '../../../model/player/player.dart';

class PlayerSprite extends StatefulWidget {
  final Player player;
  const PlayerSprite({super.key, required this.player});

  @override
  State<PlayerSprite> createState() => _PlayerSpriteState();
}

class _PlayerSpriteState extends State<PlayerSprite> {
  final AppTempPosition _tempPosition = AppTempPosition();

  @override
  Widget build(BuildContext context) {
    if (_tempPosition.oldPosition == null) {
      _tempPosition.initialize(widget.player.position);
    }

    return ChangeNotifierProxyProvider<Spawner, AppTempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _tempPosition.newPosition!.dx - (widget.player.size / 2),
          top: _tempPosition.newPosition!.dy - (widget.player.size / 2),
          child: Container(
            width: widget.player.size,
            height: widget.player.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red.withAlpha(100),
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
            ),
            child: GestureDetector(
              onPanStart: (details) {
                _tempPosition.initialize(widget.player.position);
              },
              onPanUpdate: (details) {
                setState(() {
                  _tempPosition.panUpdate(details.delta);
                });
              },
              onPanEnd: (details) {
                widget.player.changePosition(_tempPosition.newPosition!);
              },
              child: SvgPicture.asset(
                AppImages().getRaceIcon(
                  widget.player.race,
                ),
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
