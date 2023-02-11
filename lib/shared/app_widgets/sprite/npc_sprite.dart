import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app_images.dart';

class NpcSprite extends StatefulWidget {
  final Npc npc;
  const NpcSprite({super.key, required this.npc});

  @override
  State<NpcSprite> createState() => _NpcSpriteState();
}

class _NpcSpriteState extends State<NpcSprite> {
  final AppTempPosition _tempPosition = AppTempPosition();

  @override
  Widget build(BuildContext context) {
    if (_tempPosition.oldPosition == null) {
      _tempPosition.initialize(widget.npc.position);
    }

    return ChangeNotifierProxyProvider<Spawner, AppTempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _tempPosition.newPosition!.dx - (widget.npc.size / 2),
          top: _tempPosition.newPosition!.dy - (widget.npc.size / 2),
          child: Container(
            width: widget.npc.size,
            height: widget.npc.size,
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
                _tempPosition.initialize(widget.npc.position);
              },
              onPanUpdate: (details) {
                setState(() {
                  _tempPosition.panUpdate(details.delta);
                });
              },
              onPanEnd: (details) {
                widget.npc.changePosition(_tempPosition.newPosition!);
              },
              child: SvgPicture.asset(
                AppImages().getRaceIcon(
                  widget.npc.race,
                ),
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
