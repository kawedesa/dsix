import 'package:flutter/animation.dart';

import '../../combat/position.dart';

class PlayerMove {
  int raceBaseAttribute;
  int attribute;

  PlayerMove({
    required this.attribute,
    required this.raceBaseAttribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'raceBaseAttribute': raceBaseAttribute,
    };
  }

  factory PlayerMove.fromMap(Map<String, dynamic>? data) {
    return PlayerMove(
      attribute: data?['attribute'],
      raceBaseAttribute: data?['raceBaseAttribute'],
    );
  }

  factory PlayerMove.empty() {
    return PlayerMove(
      raceBaseAttribute: 0,
      attribute: 0,
    );
  }

  void setAttribute(int value) {
    raceBaseAttribute = value;
    attribute = value;
  }

  void addAttribute() {
    attribute++;
  }

  void removeAttribute() {
    attribute--;
  }

  double maxRange() {
    double range = attribute * 10 + 50;

    if (range < 0) {
      range = 0;
    }
    return range;
  }
}
