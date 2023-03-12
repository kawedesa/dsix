import 'dart:math';

import 'package:dsix/model/combat/effect/effect.dart';

class Vision {
  int attribute;
  int tempVision;

  Vision({
    required this.attribute,
    required this.tempVision,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'tempVision': tempVision,
    };
  }

  factory Vision.fromMap(Map<String, dynamic>? data) {
    return Vision(
      attribute: data?['attribute'],
      tempVision: data?['tempVision'],
    );
  }

  factory Vision.empty() {
    return Vision(
      attribute: 0,
      tempVision: 0,
    );
  }

  void setAttribute(int value) {
    attribute = value;
  }

  void addAttribute() {
    attribute++;
  }

  void removeAttribute() {
    attribute--;
  }

  double getRange() {
    double range = (attribute * 40) + tempVision + 100;

    return range;
  }

  void look() {
    int tempResult = 0;

    int roll1 = Random().nextInt(6) + 1;
    int roll2 = Random().nextInt(6) + 1;

    int result = roll1 + roll2 + attribute;

    if (result > 14) {
      tempResult = 60;
    }

    if (result > 11 && result < 15) {
      tempResult = 55;
    }

    if (result > 9 && result < 12) {
      tempResult = 50;
    }
    if (result > 6 && result < 10) {
      tempResult = 35;
    }
    if (result < 7) {
      tempResult = 0;
    }

    tempVision += tempResult;
  }

  Effect getTempVisionEffect() {
    return Effect(name: 'tempVision', description: '', value: 0, countdown: 0);
  }

  void resetTempVision() {
    tempVision = 0;
  }
}
