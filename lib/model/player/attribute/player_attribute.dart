import 'package:dsix/model/player/attribute/player_move.dart';
import 'package:dsix/model/player/attribute/player_vision.dart';

class PlayerAttribute {
  int availablePoints;
  int attack;
  int defend;
  PlayerMove move;
  PlayerVision vision;
  PlayerAttribute(
      {required this.availablePoints,
      required this.attack,
      required this.defend,
      required this.move,
      required this.vision});

  factory PlayerAttribute.empty() {
    return PlayerAttribute(
        availablePoints: 0,
        attack: 0,
        defend: 0,
        move: PlayerMove.empty(),
        vision: PlayerVision.empty());
  }

  factory PlayerAttribute.fromMap(Map<String, dynamic>? data) {
    return PlayerAttribute(
      availablePoints: data?['availablePoints'],
      attack: data?['attack'],
      defend: data?['defend'],
      move: PlayerMove.fromMap(data?['move']),
      vision: PlayerVision.fromMap(data?['vision']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'availablePoints': availablePoints,
      'attack': attack,
      'defend': defend,
      'move': move.toMap(),
      'vision': vision.toMap(),
    };
  }

  void setAttribute(String race) {
    switch (race) {
      case 'orc':
        availablePoints = 2;
        attack = 1;
        defend = 0;
        move.setAttribute(-1);
        vision.setAttribute(0);
        break;
      case 'elf':
        availablePoints = 2;
        attack = 0;
        defend = 0;
        move.setAttribute(1);
        vision.setAttribute(1);
        break;
      case 'dwarf':
        availablePoints = 2;
        attack = 0;
        defend = 1;
        move.setAttribute(0);
        vision.setAttribute(-1);
        break;
    }
  }

  void add(String attribute) {
    switch (attribute) {
      case 'attack':
        if (attack < 2) {
          attack++;
          availablePoints--;
        }
        break;
      case 'defend':
        if (defend < 2) {
          defend++;
          availablePoints--;
        }
        break;
      case 'vision':
        if (vision.attribute < 2) {
          vision.addAttribute();
          availablePoints--;
        }
        break;
      case 'move':
        if (move.attribute < 2) {
          move.addAttribute();
          availablePoints--;
        }
        break;
    }
  }

  void remove(String attribute, String race) {
    int baseAttack = 0;
    int baseDefend = 0;

    switch (race) {
      case 'orc':
        baseAttack = 1;

        break;
      case 'elf':
        break;
      case 'dwarf':
        baseDefend = 1;
        break;
    }

    switch (attribute) {
      case 'attack':
        if (attack > baseAttack) {
          attack--;
          availablePoints++;
        }
        break;
      case 'defend':
        if (defend > baseDefend) {
          defend--;
          availablePoints++;
        }
        break;
      case 'vision':
        if (vision.attribute > vision.raceBaseAttribute) {
          vision.removeAttribute();

          availablePoints++;
        }
        break;
      case 'move':
        if (move.attribute > move.raceBaseAttribute) {
          move.removeAttribute();
          availablePoints++;
        }
        break;
    }
  }
}
