import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final String icon;
  final Color color;
  final Color darkColor;
  final bool isTakingAction;
  final Function() startAction;
  final Function() resetAction;
  final Function() resetArea;

  const ActionButton({
    super.key,
    required this.icon,
    required this.color,
    required this.darkColor,
    required this.isTakingAction,
    required this.startAction,
    required this.resetAction,
    required this.resetArea,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
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
    if (widget.isTakingAction == false) {
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
        //TODO implementar increase the size when hover
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
            widget.resetArea();
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
              widget.resetAction();
            } else {
              active = true;
              reset = true;
              widget.startAction();
            }
          });
        },
      ),
    );
  }
}
