import 'package:dsix/model/player/attribute/player_attribute.dart';

import 'package:dsix/model/player/equipment/player_equipment.dart';
import 'package:dsix/model/player/life/player_life.dart';

class Player {
  String id;
  String name;
  String race;
  PlayerLife life;
  PlayerAttribute attributes;
  PlayerEquipment equipment;
  bool finished;

  Player(
      {required this.id,
      required this.name,
      required this.race,
      required this.life,
      required this.attributes,
      required this.equipment,
      required this.finished});

  factory Player.newPlayer(String id) {
    return Player(
      id: id,
      name: '',
      race: '',
      life: PlayerLife.empty(),
      attributes: PlayerAttribute.empty(),
      equipment: PlayerEquipment.empty(),
      finished: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'race': race,
      'life': life.toMap(),
      'attributes': attributes.toMap(),
      'equipment': equipment.toMap(),
      'finished': finished,
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      id: data?['id'],
      name: data?['name'],
      race: data?['race'],
      life: PlayerLife.fromMap(data?['life']),
      attributes: PlayerAttribute.fromMap(data?['attributes']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      finished: data?['finished'],
    );
  }

  void setRace(String race) {
    this.race = race;
    life.setLife(race);
    attributes.setAttribute(race);
    equipment.setWeight(race);
  }

  void finishPlayer(String name) {
    this.name = name;
    finished = true;
  }
}
