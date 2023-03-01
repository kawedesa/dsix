import 'dart:math';

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
    tempDefense = 0;

    int roll1 = Random().nextInt(6) + 1;
    int roll2 = Random().nextInt(6) + 1;

    int result = roll1 + roll2 + attribute;

    if (result > 12) {
      tempDefense = 6;
    }

    if (result > 9 && result < 12) {
      tempDefense = 4;
    }
    if (result > 6 && result < 10) {
      tempDefense = 2;
    }
    if (result < 7) {
      tempDefense = 0;
    }
  }

  void resetTempDefense() {
    tempDefense = 0;
  }
}
