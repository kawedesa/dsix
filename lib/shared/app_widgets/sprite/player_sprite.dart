import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../app_images.dart';
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
    if (drag == false) {
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
                widget.player.changePosition(_tempPosition.newPosition!);
                drag = false;
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
