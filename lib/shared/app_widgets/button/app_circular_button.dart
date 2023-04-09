import 'package:dsix/shared/app_animations.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

class AppCircularButton extends StatefulWidget {
  final Color color;
  final Color borderColor;
  final Color? iconColor;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final double size;
  final double? borderSize;
  final String? icon;
  final double? iconSize;

  const AppCircularButton({
    Key? key,
    required this.color,
    required this.borderColor,
    this.iconColor,
    this.onTap,
    this.onDoubleTap,
    required this.size,
    this.borderSize,
    this.icon,
    this.iconSize,
  }) : super(key: key);

  @override
  State<AppCircularButton> createState() => _AppCircularButtonState();
}

class _AppCircularButtonState extends State<AppCircularButton> {
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 400),
      tween: Tween<double>(
        begin: 0.0,
        end: AppLayout.avarage(context) * widget.size,
      ),
      curve: Curves.easeOutCubic,
      builder: (_, double tweenValue, __) {
        return SizedBox(
            width: tweenValue,
            height: tweenValue,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                    border: Border.all(
                      color: widget.borderColor,
                      width: (widget.borderSize == null)
                          ? AppLayout.shortest(context) * 0.003
                          : widget.borderSize!,
                    ),
                  ),
                ),
                (widget.onTap != null)
                    ? const ClipOval(
                        child: RiveAnimation.asset(
                          AppAnimations.buttonReflex,
                          fit: BoxFit.fill,
                        ),
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.all((widget.borderSize == null)
                      ? AppLayout.shortest(context) * 0.003
                      : widget.borderSize!),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.color,
                    ),
                  ),
                ),
                (widget.icon != null)
                    ? Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          widget.icon!,
                          width: (widget.iconSize == null)
                              ? tweenValue / 2
                              : tweenValue * widget.iconSize!,
                          height: (widget.iconSize == null)
                              ? tweenValue / 2
                              : tweenValue * widget.iconSize!,
                          color: (widget.iconColor != null)
                              ? widget.iconColor!
                              : Colors.transparent,
                        ))
                    : const SizedBox(),
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        (widget.onTap != null) ? widget.onTap!() : () {},
                    onDoubleTap: () => (widget.onDoubleTap != null)
                        ? widget.onDoubleTap!()
                        : () {},
                  ),
                ),
              ],
            ));
      },
    );
  }
}
