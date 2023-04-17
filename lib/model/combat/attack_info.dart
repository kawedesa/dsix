import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AttackInfo {
  Attack attack;
  double angle;
  double distance;
  Position actionCenter;

  AttackInfo({
    required this.attack,
    required this.angle,
    required this.distance,
    required this.actionCenter,
  });

  factory AttackInfo.empty() {
    return AttackInfo(
      attack: Attack.empty(),
      angle: 0,
      distance: 0,
      actionCenter: Position.empty(),
    );
  }

  factory AttackInfo.fromMap(Map<String, dynamic>? data) {
    return AttackInfo(
      attack: Attack.fromMap(data?['attack']),
      angle: data?['angle'],
      distance: data?['distance'],
      actionCenter: Position.fromMap(data?['actionCenter']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attack': attack.toMap(),
      'angle': angle,
      'distance': distance,
      'actionCenter': actionCenter.toMap(),
    };
  }

  Position getKickBackDirection() {
    Position kickBackDirection =
        actionCenter.withOffset(Offset(-math.sin(angle), math.cos(angle)));

    return kickBackDirection;
  }
}
