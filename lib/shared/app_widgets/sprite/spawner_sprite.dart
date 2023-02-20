import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpawnerSprite extends StatefulWidget {
  final Spawner spawner;
  const SpawnerSprite({super.key, required this.spawner});

  @override
  State<SpawnerSprite> createState() => _SpawnerSpriteState();
}

class _SpawnerSpriteState extends State<SpawnerSprite> {
  final TempPosition _tempPosition = TempPosition();
  bool drag = false;
  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _tempPosition.initialize(widget.spawner.position);
    }

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _tempPosition.newPosition.dx - (widget.spawner.size / 2),
          top: _tempPosition.newPosition.dy - (widget.spawner.size / 2),
          child: Container(
            width: widget.spawner.size,
            height: widget.spawner.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber.withAlpha(100),
              border: Border.all(
                color: Colors.amber,
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
                widget.spawner.changePosition(_tempPosition.newPosition);
                drag = false;
              },
            ),
          ),
        ));
  }
}
