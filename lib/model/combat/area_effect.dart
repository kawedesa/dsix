import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';
import 'range.dart';

class AreaEffect {
  Path area = Path();
  AreaEffect();

  void setArea(double angle, double distance, Position center, Range range) {
    double maxRange = distance * range.max;

    switch (range.shape) {
      case 'rectangle':
        area = Path()
          ..addRect(Rect.fromPoints(Offset(-range.width / 2, range.min),
              Offset(range.width / 2, range.min + maxRange)));

        break;

      case 'cone':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(math.sqrt(2) / 2 * (maxRange + range.min),
            math.sqrt(2) / 2 * (maxRange + range.min));
        attackShape.arcToPoint(
            Offset(-math.sqrt(2) / 2 * (maxRange + range.min),
                math.sqrt(2) / 2 * (maxRange + range.min)),
            radius: Radius.circular(maxRange + range.min));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        area = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'circle':
        area = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRange + range.min), radius: range.width));

        break;

      case 'torus':
        Path maxDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.max));

        Path minDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        area = Path.combine(
            PathOperation.difference, maxDistanceShape, minDistanceShape);

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

    area = area.transform(addRotation).shift(Offset(center.dx, center.dy));
  }

  bool insideArea(Position position) {
    return area.contains(Offset(position.dx, position.dy));
  }

  void reset() {
    area = Path();
  }
}
