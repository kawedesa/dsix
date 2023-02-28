import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';

class MouseInput extends StatefulWidget {
  final Function(Position) getMousePosition;
  final Function() onTap;
  const MouseInput(
      {super.key, required this.getMousePosition, required this.onTap});

  @override
  State<MouseInput> createState() => _MouseInputState();
}

class _MouseInputState extends State<MouseInput> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (details) {
        widget.getMousePosition(Position(
          dx: details.position.dx,
          dy: details.position.dy,
        ));
      },
      child: GestureDetector(
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
