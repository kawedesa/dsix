import 'package:flutter/material.dart';

class ActionAreaSprite extends StatelessWidget {
  final Path area;

  const ActionAreaSprite({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ActionAreaSpritePainter(
        area: area,
      ),
    );
  }
}

class ActionAreaSpritePainter extends CustomPainter {
  Path area;
  ActionAreaSpritePainter({required this.area});

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
