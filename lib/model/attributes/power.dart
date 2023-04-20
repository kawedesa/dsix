import 'dart:math';

class Power {
  int attribute;

  Power({
    required this.attribute,
  });

  Map<String, dynamic> toMap() {
    return {
      'attribute': attribute,
    };
  }

  factory Power.fromMap(Map<String, dynamic>? data) {
    return Power(
      attribute: data?['attribute'],
    );
  }

  factory Power.empty() {
    return Power(
      attribute: 0,
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

  int getRawDamage() {
    int rawDamage = 0;

    int roll1 = Random().nextInt(6) + 1;
    int roll2 = Random().nextInt(6) + 1;

    int result = roll1 + roll2 + attribute;

    if (result == 15) {
      rawDamage = 15;
    }

    if (result > 11 && result < 15) {
      rawDamage = 10;
    }

    if (result > 9 && result < 12) {
      rawDamage = 6;
    }
    if (result > 6 && result < 10) {
      rawDamage = 4;
    }
    if (result < 7) {
      rawDamage = 1;
    }

    return rawDamage;
  }
}
