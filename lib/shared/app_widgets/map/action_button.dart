import 'package:dsix/model/combat/position.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final bool active;
  final Function(Position) startAction;
  final Function() cancelAction;
  final Function() resetAction;

  const ActionButton({
    super.key,
    required this.color,
    required this.darkColor,
    required this.active,
    required this.startAction,
    required this.cancelAction,
    required this.resetAction,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  Position buttonPosition = Position.empty();

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (details) {
        buttonPosition =
            Position(dx: details.position.dx, dy: details.position.dy);
        if (widget.active) {
          widget.resetAction();
        }
      },
      child: AppCircularButton(
        color: widget.color,
        borderColor: widget.darkColor,
        size: 0.05,
        onTap: () {
          setState(() {
            if (widget.active) {
              widget.cancelAction();
            } else {
              widget.startAction(buttonPosition);
            }
          });
        },
      ),
    );
  }
}
