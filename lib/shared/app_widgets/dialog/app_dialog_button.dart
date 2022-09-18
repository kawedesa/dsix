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
            height: MediaQuery.of(context).size.shortestSide * 0.125,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: widget.color,
                width: MediaQuery.of(context).size.shortestSide * 0.004,
              ),
            ),
            child: Stack(
              children: [
                const RiveAnimation.asset(
                  'assets/animations/ui/buttonAnimation.riv',
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Text(widget.buttonText.toUpperCase(),
                      style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.shortestSide * 0.025,
                        fontWeight: FontWeight.w500,
                        letterSpacing:
                            MediaQuery.of(context).size.shortestSide * 0.008,
                        fontFamily: 'Poppins',
                        color: widget.color,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
