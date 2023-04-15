import 'package:flutter/material.dart';

class MouseInput extends StatelessWidget {
  final Function(Offset) getMouseOffset;
  final bool active;
  final Function() onTap;
  const MouseInput(
      {super.key,
      required this.getMouseOffset,
      required this.active,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return (active)
        ? MouseRegion(
            onHover: (details) {
              getMouseOffset(Offset(
                details.position.dx,
                details.position.dy,
              ));
            },
            child: GestureDetector(
              onTap: () {
                onTap();
              },
            ),
          )
        : const SizedBox();
  }
}
