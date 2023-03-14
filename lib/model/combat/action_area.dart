import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';
import 'range.dart';

class ActionArea {
  Path area = Path();
  ActionArea();

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
        Path maxRangeShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: maxRange));

        Path minRangeShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        Path adjShape = Path()
          ..addRect(Rect.fromPoints(
              Offset(-0.05, -maxRange), Offset(0.05, maxRange)));

        Path tempShape =
            Path.combine(PathOperation.difference, maxRangeShape, adjShape);

        area = Path.combine(PathOperation.difference, tempShape, minRangeShape);

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

  Path getArea(AttackInfo info) {
    double maxRange = info.distance * info.range.max;

    Path getArea = Path();

    switch (info.range.shape) {
      case 'rectangle':
        getArea = Path()
          ..addRect(Rect.fromPoints(
              Offset(-info.range.width / 2, info.range.min),
              Offset(info.range.width / 2, info.range.min + maxRange)));

        break;

      case 'cone':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(math.sqrt(2) / 2 * (maxRange + info.range.min),
            math.sqrt(2) / 2 * (maxRange + info.range.min));
        attackShape.arcToPoint(
            Offset(-math.sqrt(2) / 2 * (maxRange + info.range.min),
                math.sqrt(2) / 2 * (maxRange + info.range.min)),
            radius: Radius.circular(maxRange + info.range.min));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'circle':
        getArea = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRange + info.range.min),
              radius: info.range.width));

        break;

      case 'torus':
        Path maxRangeShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: maxRange));

        Path minRangeShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.range.min));

        Path adjShape = Path()
          ..addRect(Rect.fromPoints(
              Offset(-0.05, -maxRange), Offset(0.05, maxRange)));

        Path tempShape =
            Path.combine(PathOperation.difference, maxRangeShape, adjShape);

        getArea =
            Path.combine(PathOperation.difference, tempShape, minRangeShape);

        break;
    }

    final addRotation = Float64List.fromList([
      math.cos(info.angle),
      math.sin(info.angle),
      0,
      0,
      -math.sin(info.angle),
      math.cos(info.angle),
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

    getArea = getArea
        .transform(addRotation)
        .shift(Offset(info.actionCenter.dx, info.actionCenter.dy));
    return getArea;
  }
}
