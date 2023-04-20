import 'package:flutter/material.dart';

class HitBoxSprite extends StatelessWidget {
  final double size;
  final Path hitBox;

  const HitBoxSprite({super.key, required this.size, required this.hitBox});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(bottom: size * 0.6),
        child: CustomPaint(
          size: Size(size, size),
          painter: HitBoxSpritePainter(
            hitBox: hitBox,
          ),
        ),
      ),
    );
  }
}

class HitBoxSpritePainter extends CustomPainter {
  Path hitBox;
  Path displayHitBox = Path();
  HitBoxSpritePainter({
    required this.hitBox,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height * 0.8);
    displayHitBox = hitBox.shift(center);

    // //DEBUG COLORS
    // final fillColor = Paint()..color = Colors.red.withAlpha(75);
    // final strokeColor = Paint()
    //   ..color = Colors.red
    //   ..strokeWidth = 0.25
    //   ..style = PaintingStyle.stroke
    //   ..strokeJoin = StrokeJoin.round;

    // canvas.drawPath(
    //   displayHitBox,
    //   strokeColor,
    // );

    // canvas.drawPath(
    //   displayHitBox,
    //   fillColor,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    return displayHitBox.contains(position);
  }
}
