import 'package:flutter/material.dart';

class AreaEffectSprite extends StatelessWidget {
  final Offset center;
  final double size;
  final double angle;
  final Path area;

  const AreaEffectSprite(
      {Key? key,
      required this.center,
      required this.size,
      required this.angle,
      required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final center = Offset(size / 2, size / 2);

    return Positioned(
      left: center.dx - size / 2,
      top: center.dy - size / 2,
      child: Transform.rotate(
        angle: angle,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: AreaEffectSpritePainter(
              area: area,
            ),
          ),
        ),
      ),
    );
  }
}

class AreaEffectSpritePainter extends CustomPainter {
  Path area;
  AreaEffectSpritePainter({required this.area});

  @override
  void paint(Canvas canvas, Size size) {
    final fillColor = Paint()..color = Colors.red.withOpacity(0.5);

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
