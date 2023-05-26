import 'package:flutter/material.dart';

class MapText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Color? paintColor;
  final Color? strokeColor;

  const MapText(
      {super.key,
      this.text,
      required this.fontSize,
      this.paintColor,
      this.strokeColor});

  @override
  Widget build(BuildContext context) {
    return (text == null)
        ? const SizedBox()
        : Stack(
            children: [
              Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: fontSize,
                  letterSpacing: 0.01,
                  fontFamily: 'SuperComic',
                  color: (paintColor == null) ? Colors.white : paintColor,
                ),
              ),
              Text(
                text!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = fontSize * 0.075
                    ..color =
                        (strokeColor == null) ? Colors.black : strokeColor!,
                  fontSize: fontSize,
                  letterSpacing: 0.01,
                  fontFamily: 'SuperComic',
                ),
              ),
            ],
          );
  }
}
