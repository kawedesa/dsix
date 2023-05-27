import 'package:flutter/material.dart';

class ActionAreaImage extends CustomPainter {
  Path area;
  ActionAreaImage({required this.area});

  @override
  void paint(Canvas canvas, Size size) {
    final fillColor = Paint()..color = Colors.red.withAlpha(75);

    final strokeColor = Paint()
      ..color = Colors.red
      ..strokeWidth = 0.25
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(
      area,
      strokeColor,
    );

    canvas.drawPath(
      area,
      fillColor,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
