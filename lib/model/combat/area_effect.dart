import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/combat/range.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';

class AreaEffect {
  Path area = Path();
  AreaEffect();

  void setArea(double angle, double distance, Position position, Range range) {
    double maxRange = distance * range.max;

    switch (range.type) {
      case 'cone':
        Path attack = Path();
        attack = Path();
        attack.moveTo(0, 0);
        attack.lineTo(math.sqrt(2) / 2 * maxRange, math.sqrt(2) / 2 * maxRange);
        attack.arcToPoint(
            Offset(-math.sqrt(2) / 2 * maxRange, math.sqrt(2) / 2 * maxRange),
            radius: Radius.circular(maxRange));
        attack.close();

        Path minDistance = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        area = Path.combine(PathOperation.difference, attack, minDistance);

        break;

      case 'rectangle':
        Path attack = Path()
          ..addRect(Rect.fromPoints(
              Offset(-range.width / 2, 0), Offset(range.width / 2, maxRange)));

        Path minDistance = Path()
          ..addRect(Rect.fromPoints(
              Offset(-range.width / 2, 0), Offset(range.width / 2, range.min)));

        area = Path.combine(PathOperation.difference, attack, minDistance);

        break;
      case 'circle':
        area = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRange), radius: range.width));

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
