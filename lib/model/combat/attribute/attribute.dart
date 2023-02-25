import 'power.dart';
import 'vision.dart';
import 'defense.dart';
import 'movement.dart';

class Attribute {
  int availablePoints;
  Power power;
  Defense defense;
  Movement movement;
  Vision vision;
  Attribute(
      {required this.availablePoints,
      required this.power,
      required this.defense,
      required this.movement,
      required this.vision});

  factory Attribute.empty() {
    return Attribute(
        availablePoints: 0,
        power: Power.empty(),
        defense: Defense.empty(),
        movement: Movement.empty(),
        vision: Vision.empty());
  }

  factory Attribute.fromMap(Map<String, dynamic>? data) {
    return Attribute(
      availablePoints: data?['availablePoints'],
      power: Power.fromMap(data?['power']),
      defense: Defense.fromMap(data?['defense']),
      movement: Movement.fromMap(data?['movement']),
      vision: Vision.fromMap(data?['vision']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'availablePoints': availablePoints,
      'power': power.toMap(),
      'defense': defense.toMap(),
      'movement': movement.toMap(),
      'vision': vision.toMap(),
    };
  }

  void setAttribute(String race) {
    switch (race) {
      case 'orc':
        availablePoints = 2;
        power.setAttribute(1);
        defense.setAttribute(0);
        movement.setAttribute(-1);
        vision.setAttribute(0);
        break;
      case 'elf':
        availablePoints = 2;
        power.setAttribute(0);
        defense.setAttribute(0);
        movement.setAttribute(1);
        vision.setAttribute(1);
        break;
      case 'dwarf':
        availablePoints = 2;
        power.setAttribute(0);
        defense.setAttribute(1);
        movement.setAttribute(0);
        vision.setAttribute(-1);
        break;
    }
  }

  void add(String attribute) {
    switch (attribute) {
      case 'power':
        if (power.attribute < 2) {
          power.addAttribute();
          availablePoints--;
        }
        break;
      case 'defense':
        if (defense.attribute < 2) {
          defense.addAttribute();
          availablePoints--;
        }
        break;
      case 'movement':
        if (movement.attribute < 2) {
          movement.addAttribute();
          availablePoints--;
        }
        break;
      case 'vision':
        if (vision.attribute < 2) {
          vision.addAttribute();
          availablePoints--;
        }
        break;
    }
  }

  void remove(String attribute, String race) {
    int racePower = 0;
    int raceDefense = 0;
    int raceMovement = 0;
    int raceVision = 0;

    switch (race) {
      case 'orc':
        racePower = 1;
        raceDefense = 0;
        raceMovement = -1;
        raceVision = 0;

        break;
      case 'elf':
        racePower = 0;
        raceDefense = 0;
        raceMovement = 1;
        raceVision = 1;

        break;
      case 'dwarf':
        racePower = 0;
        raceDefense = 1;
        raceMovement = 0;
        raceVision = -1;

        break;
    }

    switch (attribute) {
      case 'power':
        if (power.attribute > racePower) {
          power.removeAttribute();

          availablePoints++;
        }
        break;
      case 'defense':
        if (defense.attribute > raceDefense) {
          defense.removeAttribute();
          availablePoints++;
        }
        break;

      case 'movement':
        if (movement.attribute > raceMovement) {
          movement.removeAttribute();
          availablePoints++;
        }
        break;
      case 'vision':
        if (vision.attribute > raceVision) {
          vision.removeAttribute();

          availablePoints++;
        }
        break;
    }
  }
}
