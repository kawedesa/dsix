import 'dart:math';

import 'package:dsix/model/combat/effect/effect.dart';

class Defense {
  int attribute;
  int tempArmor;

  Defense({
    required this.attribute,
    required this.tempArmor,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
      'tempArmor': tempArmor,
    };
  }

  factory Defense.fromMap(Map<String, dynamic>? data) {
    return Defense(
      attribute: data?['attribute'],
      tempArmor: data?['tempArmor'],
    );
  }

  factory Defense.empty() {
    return Defense(attribute: 0, tempArmor: 0);
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

    tempArmor += tempResult;
  }

  void reduceTempArmor(int value) {
    tempArmor -= value;
    if (tempArmor < 1) {
      tempArmor = 0;
    }
  }

  void resetTempDefense() {
    tempArmor = 0;
  }
}
