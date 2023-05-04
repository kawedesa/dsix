import 'package:dsix/shared/app_animations.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AppTextButton extends StatelessWidget {
  final Color color;
  final String buttonText;
  final Function()? onTap;
  const AppTextButton(
      {Key? key,
      required this.color,
      required this.buttonText,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0, end: 255),
        builder: (_, double aplhaValue, __) {
          return Container(
            width: AppLayout.avarage(context) * 0.2,
            height: AppLayout.avarage(context) * 0.05,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: color,
                width: AppLayout.avarage(context) * 0.0025,
              ),
            ),
            child: Stack(
              children: [
                const RiveAnimation.asset(
                  AppAnimations.buttonReflex,
                  fit: BoxFit.fill,
                ),
                Center(
                  child: AppText(
                    text: buttonText.toUpperCase(),
                    fontSize: 0.0125,
                    letterSpacing: 0.002,
                    color: color,
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
