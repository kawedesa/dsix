import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AppDialogButton extends StatefulWidget {
  final Color color;
  final String buttonText;
  final Function()? onTap;
  const AppDialogButton(
      {Key? key,
      required this.color,
      required this.buttonText,
      required this.onTap})
      : super(key: key);

  @override
  State<AppDialogButton> createState() => _AppDialogButtonState();
}

class _AppDialogButtonState extends State<AppDialogButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0, end: 255),
        builder: (_, double aplhaValue, __) {
          return Container(
            width: double.infinity,
            height: AppLayout.shortest(context) * 0.125,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: widget.color,
                width: AppLayout.shortest(context) * 0.004,
              ),
            ),
            child: Stack(
              children: [
                const RiveAnimation.asset(
                  'assets/animations/ui/buttonAnimation.riv',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: AppText(
                    text: widget.buttonText.toUpperCase(),
                    fontSize: 0.025,
                    letterSpacing: 0.008,
                    color: widget.color,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
