import 'dart:ui';

import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';

class ActionArea {
  Path area = Path();
  ActionArea();

  void setArea(AttackInfo info) {
    area = Path();
    area = getArea(info);
  }

  Path getArea(AttackInfo info) {
    Path getArea = Path();

    double maxRange = info.distance * info.range.max;

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
        attackShape.lineTo(info.range.width / 2, info.range.max);
        attackShape.arcToPoint(Offset(-info.range.width / 2, info.range.max),
            radius: Radius.circular(info.range.width / 2 + info.range.max / 2));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'double cone':
        Path cone01 = Path();
        cone01 = Path();
        cone01.moveTo(0, 0);
        cone01.lineTo(info.range.width / 2, info.range.max);
        cone01.arcToPoint(Offset(-info.range.width / 2, info.range.max),
            radius: Radius.circular(info.range.width / 2 + info.range.max / 2));
        cone01.close();

        Path cone02 = Path();
        cone02 = Path();
        cone02.moveTo(0, 0);
        cone02.lineTo(info.range.width / 2, -info.range.max);
        cone02.arcToPoint(Offset(-info.range.width / 2, -info.range.max),
            clockwise: false,
            radius: Radius.circular(info.range.width / 2 + info.range.max / 2));

        cone02.close();

        Path attackArea = Path.combine(PathOperation.union, cone01, cone02);
        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackArea, minDistanceShape);

        break;

      case 'circle':
        getArea = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRange + info.range.min),
              radius: info.range.width));

        break;

      case 'ring':
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

      case 'ring offset':
        Path outterCircle = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, info.range.min), radius: info.range.max));

        Path innerCircle = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, info.range.min),
              radius: info.range.max - info.range.width));

        Path ring =
            Path.combine(PathOperation.difference, outterCircle, innerCircle);
        ring.fillType = PathFillType.evenOdd;

        Path eraseShape = Path()
          ..addOval(Rect.fromCircle(center: const Offset(0, 0), radius: 3.5));

        getArea = Path.combine(PathOperation.difference, ring, eraseShape);

        break;

      case 'triangle':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(info.range.width / 2, 0);
        attackShape.lineTo(0, info.range.max);
        attackShape.lineTo(-info.range.width / 2, 0);
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'diamond':
        getArea = Path();
        getArea.moveTo(info.range.width / 2, info.range.min);
        getArea.lineTo(0, info.range.min + info.range.max);
        getArea.lineTo(-info.range.width / 2, info.range.min);
        getArea.lineTo(0, info.range.min - info.range.max);
        getArea.close();

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

  bool insideArea(Position position) {
    return area.contains(Offset(position.dx, position.dy));
  }

  void reset() {
    area = Path();
  }
}
