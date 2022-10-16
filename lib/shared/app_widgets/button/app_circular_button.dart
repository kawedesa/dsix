import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class AppCircularButton extends StatefulWidget {
  final Color color;
  final Color borderColor;
  final Color? iconColor;
  final Function()? onTap;
  final double size;
  final String? icon;

  const AppCircularButton({
    Key? key,
    required this.color,
    required this.borderColor,
    this.iconColor,
    this.onTap,
    required this.size,
    this.icon,
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
        end: AppLayout.shortest(context) * widget.size,
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
                      width: AppLayout.shortest(context) * 0.005,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () =>
                        (widget.onTap != null) ? widget.onTap!() : () {},
                  ),
                ),
                (widget.icon != null)
                    ? TransparentPointer(
                        child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              widget.icon!,
                              width: tweenValue / 2,
                              height: tweenValue / 2,
                              color: (widget.iconColor != null)
                                  ? widget.iconColor!
                                  : Colors.transparent,
                            )))
                    : const SizedBox(),
                (widget.onTap != null)
                    ? const TransparentPointer(
                        child: ClipOval(
                          child: RiveAnimation.asset(
                            'assets/animations/ui/buttonAnimation.riv',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ));
      },
    );
  }
}
