import 'package:dsix/model/combat/ability.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ActionInfo {
  Attack attack;
  Ability ability;
  double angle;
  double distance;
  Position actionCenter;

  ActionInfo({
    required this.attack,
    required this.ability,
    required this.angle,
    required this.distance,
    required this.actionCenter,
  });

  factory ActionInfo.empty() {
    return ActionInfo(
      attack: Attack.empty(),
      ability: Ability.empty(),
      angle: 0,
      distance: 0,
      actionCenter: Position.empty(),
    );
  }

  factory ActionInfo.fromMap(Map<String, dynamic>? data) {
    return ActionInfo(
      attack: Attack.fromMap(data?['attack']),
      ability: Ability.fromMap(data?['ability']),
      angle: data?['angle'],
      distance: data?['distance'],
      actionCenter: Position.fromMap(data?['actionCenter']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attack': attack.toMap(),
      'ability': ability.toMap(),
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
