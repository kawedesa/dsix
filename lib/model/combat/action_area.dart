import 'dart:ui';
import 'package:dsix/model/combat/action_info.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/combat/range.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:typed_data';

class ActionArea {
  Path area = Path();
  ActionArea();

  void setArea(ActionInfo info) {
    area = Path();
    area = getArea(info);
  }

  Path getArea(ActionInfo info) {
    Path getArea = Path();

    Range range = Range.empty();

    if (info.attack.name == '') {
      range = info.ability.range;
    } else {
      range = info.attack.range;
    }

    double maxRangeWithDistance = info.distance * range.max;

    switch (range.shape) {
      case 'rectangle':
        getArea = Path()
          ..addRect(Rect.fromPoints(Offset(-range.width / 2, range.min),
              Offset(range.width / 2, range.min + range.max)));

        break;

      case 'cone':
        Path attackShape = Path();
        attackShape = Path();
        attackShape.moveTo(0, 0);
        attackShape.lineTo(range.width / 2, range.max);
        attackShape.arcToPoint(Offset(-range.width / 2, range.max),
            radius: Radius.circular(range.width / 2 + range.max / 2));
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'double cone':
        Path cone01 = Path();
        cone01 = Path();
        cone01.moveTo(0, 0);
        cone01.lineTo(range.width / 2, range.max);
        cone01.arcToPoint(Offset(-range.width / 2, range.max),
            radius: Radius.circular(range.width / 2 + range.max / 2));
        cone01.close();

        Path cone02 = Path();
        cone02 = Path();
        cone02.moveTo(0, 0);
        cone02.lineTo(range.width / 2, -range.max);
        cone02.arcToPoint(Offset(-range.width / 2, -range.max),
            clockwise: false,
            radius: Radius.circular(range.width / 2 + range.max / 2));

        cone02.close();

        Path attackArea = Path.combine(PathOperation.union, cone01, cone02);
        Path minDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        getArea = Path.combine(
            PathOperation.difference, attackArea, minDistanceShape);

        break;

      case 'circle':
        getArea = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, maxRangeWithDistance + range.min),
              radius: range.width));

        break;

      case 'ring':
        Path maxRangeShape = Path()
          ..addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: maxRangeWithDistance));

        Path minRangeShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

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
          ..addOval(
              Rect.fromCircle(center: Offset(0, range.min), radius: range.max));

        Path innerCircle = Path()
          ..addOval(Rect.fromCircle(
              center: Offset(0, range.min), radius: range.max - range.width));

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
        attackShape.lineTo(range.width / 2, 0);
        attackShape.lineTo(0, range.max);
        attackShape.lineTo(-range.width / 2, 0);
        attackShape.close();

        Path minDistanceShape = Path()
          ..addOval(
              Rect.fromCircle(center: const Offset(0, 0), radius: range.min));

        getArea = Path.combine(
            PathOperation.difference, attackShape, minDistanceShape);

        break;

      case 'diamond':
        getArea = Path();
        getArea.moveTo(range.width / 2, range.min);
        getArea.lineTo(0, range.min + range.max);
        getArea.lineTo(-range.width / 2, range.min);
        getArea.lineTo(0, range.min - range.max);
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

    getArea =
        getArea.transform(addRotation).shift(info.actionCenter.getOffset());
    return getArea;
  }

  bool insideArea(Position position) {
    return area.contains(Offset(position.dx, position.dy));
  }

  void reset() {
    area = Path();
  }
}
