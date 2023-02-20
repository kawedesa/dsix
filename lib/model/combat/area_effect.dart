import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';

class AreaEffect {
  Path area = Path();
  AreaEffect();

  void setArea(double angle, double distance, Position position, String type) {
    switch (type) {
      case 'cone':
        Path attack = Path();
        attack = Path();
        attack.moveTo(0, 0);
        attack.lineTo(math.sqrt(2) / 4 * distance, math.sqrt(2) / 4 * distance);
        attack.arcToPoint(
            Offset(-math.sqrt(2) / 4 * distance, math.sqrt(2) / 4 * distance),
            radius: Radius.circular(distance / 2));
        attack.close();

        Path minDistance = Path()
          ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 5));

        area = Path.combine(PathOperation.difference, attack, minDistance);

        break;

      case 'rectangle':
        Path attack = Path()
          ..addRect(Rect.fromPoints(const Offset(-5, 0), Offset(5, distance)));

        Path minDistance = Path()
          ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 5));

        area = Path.combine(PathOperation.difference, attack, minDistance);

        break;
      case 'circle':
        area = Path()
          ..addOval(
              Rect.fromCircle(center: Offset(0, distance / 2), radius: 10));

        break;
    }

    final addRotation = Float64List.fromList([
      math.cos(angle),
      math.sin(angle),
      0,
      0,
      -math.sin(angle),
      math.cos(angle),
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1
    ]);

    area = area.transform(addRotation).shift(Offset(position.dx, position.dy));
  }

  bool insideArea(Position position) {
    return area.contains(Offset(position.dx, position.dy));
  }

  void reset() {
    area = Path();
  }
}
