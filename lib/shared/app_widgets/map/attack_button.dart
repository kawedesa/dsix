import 'package:dsix/model/combat/position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class AttackButton extends StatefulWidget {
  final String icon;
  final Color color;
  final Color darkColor;
  final bool isAttacking;
  final Function(Position) startAttack;
  final Function() cancelAttack;
  final Function() resetAttack;

  const AttackButton({
    super.key,
    required this.icon,
    required this.color,
    required this.darkColor,
    required this.isAttacking,
    required this.startAttack,
    required this.cancelAttack,
    required this.resetAttack,
  });

  @override
  State<AttackButton> createState() => _AttackButtonState();
}

class _AttackButtonState extends State<AttackButton> {
  Position buttonPosition = Position.empty();
  bool active = false;
  bool reset = false;

  Color getDetailColor() {
    if (reset) {
      return AppColors.negative;
    }

    if (active) {
      return Colors.white;
    } else {
      return widget.darkColor;
    }
  }

  Color getBackgroundColor() {
    if (reset) {
      return AppColors.negative;
    }

    if (active) {
      return Colors.white;
    } else {
      return widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isAttacking == false) {
      active = false;
      reset = false;
    }

    return MouseRegion(
      onEnter: (details) {
        if (active) {
          setState(() {
            reset = true;
          });
        }
      },
      onExit: (details) {
        if (active) {
          setState(() {
            reset = false;
          });
        }
      },
      onHover: (details) {
        buttonPosition =
            Position(dx: details.position.dx, dy: details.position.dy);
        if (active) {
          setState(() {
            reset = true;
            widget.resetAttack();
          });
        }
      },
      child: AppCircularButton(
        color: widget.color.withAlpha(200),
        icon: widget.icon,
        iconColor: getDetailColor(),
        borderColor: getDetailColor(),
        size: 0.05,
        onTap: () {
          setState(() {
            if (active) {
              active = false;
              reset = false;
              widget.cancelAttack();
            } else {
              active = true;
              reset = true;
              widget.startAttack(buttonPosition);
            }
          });
        },
      ),
    );
  }
}
