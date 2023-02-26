import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';

import 'attack.dart';

class AreaEffect {
  Path area = Path();
  AreaEffect();

  void setArea(
      double angle, double distance, Position position, Attack attack) {
    double maxRange = distance * attack.range.max;

    switch (attack.name) {
      case 'bite':
        Path attackShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, maxRange)));

        Path minDistanceShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, attack.range.min)));

        area = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'punch':
        Path attackShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, maxRange)));

        Path minDistanceShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, attack.range.min)));

        area = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'slash':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(
            math.sqrt(2) / 2 * maxRange, math.sqrt(2) / 2 * maxRange);
        attackShape.arcToPoint(
            Offset(-math.sqrt(2) / 2 * maxRange, math.sqrt(2) / 2 * maxRange),
            radius: Radius.circular(maxRange));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: attack.range.min));

        area = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'shot':
        Path attackShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, maxRange)));

        Path minDistanceShape = Path()
          ..addRect(Rect.fromPoints(Offset(-attack.range.width / 2, 0),
              Offset(attack.range.width / 2, attack.range.min)));

        area = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'blast':
        area = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRange + attack.range.min),
              radius: attack.range.width));

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
