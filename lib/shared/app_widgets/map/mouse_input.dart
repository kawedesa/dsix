import 'package:flutter/material.dart';

class MouseInput extends StatefulWidget {
  final Function(Offset) getMouseOffset;
  final bool active;
  final Function() onTap;
  const MouseInput(
      {super.key,
      required this.getMouseOffset,
      required this.active,
      required this.onTap});

  @override
  State<MouseInput> createState() => _MouseInputState();
}

class _MouseInputState extends State<MouseInput> {
  @override
  Widget build(BuildContext context) {
    return (widget.active)
        ? MouseRegion(
            onHover: (details) {
              widget.getMouseOffset(Offset(
                details.position.dx,
                details.position.dy,
              ));
            },
            child: GestureDetector(
              onTap: () {
                widget.onTap();
              },
            ),
          )
        : const SizedBox();
  }
}
