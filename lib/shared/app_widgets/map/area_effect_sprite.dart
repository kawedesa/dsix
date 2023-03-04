import 'package:flutter/material.dart';

class AreaEffectSprite extends StatelessWidget {
  final Path area;

  const AreaEffectSprite({Key? key, required this.area}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AreaEffectSpritePainter(
        area: area,
      ),
    );
  }
}

class AreaEffectSpritePainter extends CustomPainter {
  Path area;
  AreaEffectSpritePainter({required this.area});

  @override
  void paint(Canvas canvas, Size size) {
    // final fillColor = Paint()..color = Colors.red.withOpacity(0.25);
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
