import 'dart:math';

import 'package:dsix/model/combat/effect/effect.dart';

class Defense {
  int attribute;
  int tempDefense;

  Defense({
    required this.attribute,
    required this.tempDefense,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'tempDefense': tempDefense,
    };
  }

  factory Defense.fromMap(Map<String, dynamic>? data) {
    return Defense(
      attribute: data?['attribute'],
      tempDefense: data?['tempDefense'],
    );
  }

  factory Defense.empty() {
    return Defense(attribute: 0, tempDefense: 0);
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

  void defend() {
    int tempResult = 0;

    int roll1 = Random().nextInt(6) + 1;
    int roll2 = Random().nextInt(6) + 1;

    int result = roll1 + roll2 + attribute;

    if (result > 14) {
      tempResult = 13;
    }

    if (result > 11 && result < 15) {
      tempResult = 9;
    }

    if (result > 9 && result < 12) {
      tempResult = 6;
    }
    if (result > 6 && result < 10) {
      tempResult = 3;
    }
    if (result < 7) {
      tempResult = 1;
    }

    tempDefense += tempResult;
  }

  Effect getTempArmorEffect() {
    return Effect(
        name: 'tempArmor', description: '', value: tempDefense, countdown: 0);
  }

  void reduceTempArmor(int value) {
    tempDefense -= value;
    if (tempDefense < 1) {
      tempDefense = 0;
    }
  }

  void resetTempDefense() {
    tempDefense = 0;
  }
}
