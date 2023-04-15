import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  final int id;
  final String icon;
  final Color color;
  final Color darkColor;
  final bool selected;
  final bool hide;
  final Function() startAction;
  final Function() resetAction;
  final Function() resetArea;

  const ActionButton({
    super.key,
    required this.id,
    required this.icon,
    required this.color,
    required this.darkColor,
    required this.selected,
    required this.hide,
    required this.startAction,
    required this.resetAction,
    required this.resetArea,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool reset = false;
  bool hover = false;

  Color getDetailColor() {
    if (reset) {
      return AppColors.negative;
    }

    if (widget.selected) {
      return Colors.white;
    }

    if (hover) {
      return Colors.white;
    } else {
      return widget.darkColor;
    }
  }

  Color getBackgroundColor() {
    if (reset) {
      return AppColors.negative;
    }

    if (widget.selected) {
      return Colors.white;
    }

    if (hover) {
      return Colors.white;
    } else {
      return widget.color;
    }
  }

  double getSize() {
    if (hover) {
      return 0.035;
    } else {
      return 0.03;
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.hide)
        ? SizedBox(
            width: AppLayout.avarage(context) * 0.03,
            height: AppLayout.avarage(context) * 0.03,
          )
        : MouseRegion(
            onEnter: (details) {
              if (widget.selected) {
                reset = true;
                widget.resetArea();
              }
              hover = true;
              setState(() {});
            },
            onExit: (details) {
              reset = false;
              hover = false;
              setState(() {});
            },
            onHover: (details) {
              if (widget.selected) {
                reset = true;
                widget.resetArea();
              }
              hover = true;
              setState(() {});
            },
            child: AppCircularButton(
              color: widget.color.withAlpha(175),
              icon: widget.icon,
              iconSize: 1,
              iconColor: getDetailColor().withAlpha(225),
              borderColor: getDetailColor().withAlpha(225),
              size: getSize(),
              onTap: () {
                if (widget.selected) {
                  widget.resetAction();
                  hover = false;
                  reset = false;
                } else {
                  widget.startAction();
                }
                setState(() {});
              },
            ),
          );
  }
}
