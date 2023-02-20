import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app_images.dart';

class NpcSprite extends StatefulWidget {
  final Npc npc;
  final String viewer;
  const NpcSprite({super.key, required this.npc, required this.viewer});

  @override
  State<NpcSprite> createState() => _NpcSpriteState();
}

class _NpcSpriteState extends State<NpcSprite> {
  final TempPosition _tempPosition = TempPosition();
  bool drag = false;

  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _tempPosition.initialize(widget.npc.position);
    }

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _tempPosition.newPosition.dx - (widget.npc.size / 2),
          top: _tempPosition.newPosition.dy - (widget.npc.size / 2),
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
                drag = true;
              },
              onPanUpdate: (details) {
                setState(() {
                  _tempPosition.panUpdate(details.delta);
                });
              },
              onPanEnd: (details) {
                widget.npc.changePosition(_tempPosition.newPosition);
                drag = false;
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
