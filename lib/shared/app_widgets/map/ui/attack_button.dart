import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class AttackButton extends StatefulWidget {
  final String icon;
  final Color color;
  final Color darkColor;
  final bool isAttacking;
  final Function() startAttack;
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
        if (active) {
          setState(() {
            reset = true;
            widget.resetAttack();
          });
        }
      },
      child: AppCircularButton(
        color: widget.color.withAlpha(175),
        icon: widget.icon,
        iconSize: 0.75,
        iconColor: getDetailColor().withAlpha(225),
        borderColor: getDetailColor().withAlpha(225),
        size: 0.04,
        onTap: () {
          setState(() {
            if (active) {
              active = false;
              reset = false;
              widget.cancelAttack();
            } else {
              active = true;
              reset = true;
              widget.startAttack();
            }
          });
        },
      ),
    );
  }
}