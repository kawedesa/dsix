import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared_widgets/text/app_text.dart';

class ActionButton extends StatefulWidget {
  final int id;
  final String icon;
  final Color color;
  final Color darkColor;
  final bool selected;
  final bool hide;
  final int? cooldown;
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
    this.cooldown,
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
        : SizedBox(
            width: AppLayout.avarage(context) * 0.035,
            height: AppLayout.avarage(context) * 0.035,
            child: MouseRegion(
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
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
                  ),
                  (widget.cooldown == null)
                      ? const SizedBox()
                      : Align(
                          alignment: Alignment.center,
                          child: AppText(
                              text: widget.cooldown.toString(),
                              fontSize: 0.015,
                              bold: true,
                              letterSpacing: 0,
                              color: AppColors.uiColor),
                        ),
                ],
              ),
            ),
          );
  }
}
