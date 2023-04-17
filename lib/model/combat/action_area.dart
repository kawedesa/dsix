import 'dart:ui';
import 'package:dsix/model/combat/attack_info.dart';
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

    double maxRangeWithDistance = info.distance * info.attack.range.max;

    switch (info.attack.range.shape) {
      case 'rectangle':
        getArea = Path()
          ..addRect(Rect.fromPoints(
              Offset(-info.attack.range.width / 2, info.attack.range.min),
              Offset(info.attack.range.width / 2,
                  info.attack.range.min + info.attack.range.max)));

        break;

      case 'cone':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(info.attack.range.width / 2, info.attack.range.max);
        attackShape.arcToPoint(
            Offset(-info.attack.range.width / 2, info.attack.range.max),
            radius: Radius.circular(
                info.attack.range.width / 2 + info.attack.range.max / 2));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.attack.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'double cone':
        Path cone01 = Path();
        cone01 = Path();
        cone01.moveTo(0, 0);
        cone01.lineTo(info.attack.range.width / 2, info.attack.range.max);
        cone01.arcToPoint(
            Offset(-info.attack.range.width / 2, info.attack.range.max),
            radius: Radius.circular(
                info.attack.range.width / 2 + info.attack.range.max / 2));
        cone01.close();

        Path cone02 = Path();
        cone02 = Path();
        cone02.moveTo(0, 0);
        cone02.lineTo(info.attack.range.width / 2, -info.attack.range.max);
        cone02.arcToPoint(
            Offset(-info.attack.range.width / 2, -info.attack.range.max),
            clockwise: false,
            radius: Radius.circular(
                info.attack.range.width / 2 + info.attack.range.max / 2));

        cone02.close();

        Path attackArea = Path.combine(PathOperation.union, cone01, cone02);
        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.attack.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackArea, minDistanceShape);

        break;

      case 'circle':
        getArea = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRangeWithDistance + info.attack.range.min),
              radius: info.attack.range.width));

        break;

      case 'ring':
        Path maxRangeShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: maxRangeWithDistance));

        Path minRangeShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.attack.range.min));

        Path adjShape = Path()
          ..addRect(Rect.fromPoints(Offset(-0.05, -maxRangeWithDistance),
              Offset(0.05, maxRangeWithDistance)));

        Path tempShape =
            Path.combine(PathOperation.difference, maxRangeShape, adjShape);

        getArea =
            Path.combine(PathOperation.difference, tempShape, minRangeShape);

        break;

      case 'ring offset':
        Path outterCircle = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, info.attack.range.min),
              radius: info.attack.range.max));

        Path innerCircle = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, info.attack.range.min),
              radius: info.attack.range.max - info.attack.range.width));

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
        attackShape.lineTo(info.attack.range.width / 2, 0);
        attackShape.lineTo(0, info.attack.range.max);
        attackShape.lineTo(-info.attack.range.width / 2, 0);
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: info.attack.range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'diamond':
        getArea = Path();
        getArea.moveTo(info.attack.range.width / 2, info.attack.range.min);
        getArea.lineTo(0, info.attack.range.min + info.attack.range.max);
        getArea.lineTo(-info.attack.range.width / 2, info.attack.range.min);
        getArea.lineTo(0, info.attack.range.min - info.attack.range.max);
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
