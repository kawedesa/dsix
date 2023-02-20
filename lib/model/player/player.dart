import 'dart:math';
import 'package:dsix/model/player/attribute/player_attribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/player/equipment/player_equipment.dart';
import 'package:dsix/model/combat/life.dart';
import '../combat/damage.dart';
import '../combat/position.dart';

class Player {
  String id;
  String name;
  String race;
  double size;
  Life life;
  Position position;
  PlayerAttribute attributes;
  PlayerEquipment equipment;
  bool ready;

  Player(
      {required this.id,
      required this.name,
      required this.race,
      required this.size,
      required this.life,
      required this.position,
      required this.attributes,
      required this.equipment,
      required this.ready});

  final database = FirebaseFirestore.instance;

  factory Player.empty() {
    return Player(
      id: '',
      name: '',
      race: '',
      size: 0,
      life: Life.empty(),
      position: Position.empty(),
      attributes: PlayerAttribute.empty(),
      equipment: PlayerEquipment.empty(),
      ready: false,
    );
  }

  factory Player.newPlayer(String id) {
    return Player(
      id: id,
      name: '',
      race: '',
      size: 15,
      life: Life.empty(),
      position: Position.empty(),
      attributes: PlayerAttribute.empty(),
      equipment: PlayerEquipment.empty(),
      ready: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'position': position.toMap(),
      'attributes': attributes.toMap(),
      'equipment': equipment.toMap(),
      'ready': ready,
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      id: data?['id'],
      name: data?['name'],
      race: data?['race'],
      size: data?['size'],
      life: Life.fromMap(data?['life']),
      position: Position.fromMap(data?['position']),
      attributes: PlayerAttribute.fromMap(data?['attributes']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      ready: data?['ready'],
    );
  }

  void setRace(String race) {
    this.race = race;
    life.setLife(race);
    attributes.setAttribute(race);
    equipment.setWeight(race);
  }

  void chooseName(String name) {
    this.name = name;
  }

  void iAmReady() {
    ready = true;
    update();
  }

  void iAmNotReady() {
    ready = false;
    update();
  }

  void spawn(Position spawnerPosition, double spawnerSize) {
    double dx = spawnerPosition.dx +
        Random().nextDouble() * spawnerSize -
        spawnerSize / 2;
    double dy = spawnerPosition.dy +
        Random().nextDouble() * spawnerSize -
        spawnerSize / 2;
    position.dx = dx;
    position.dy = dy;
    update();
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  void receiveAttack(Damage rawDamage) {
    int damageAfterArmor = equipment.calculateDamage(rawDamage);

    life.receiveDamage(damageAfterArmor);
    update();
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(id)
        .set(toMap());
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(id)
        .update(toMap());
  }
}
