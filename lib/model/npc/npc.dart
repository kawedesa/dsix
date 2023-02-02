import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/life.dart';

import '../combat/Armor.dart';
import '../combat/damage.dart';

class Npc {
  int id;
  String race;
  double size;
  Life life;
  Damage damage;
  Armor armor;
  Offset position;
  Npc({
    required this.id,
    required this.race,
    required this.size,
    required this.life,
    required this.damage,
    required this.armor,
    required this.position,
  });

  final database = FirebaseFirestore.instance;

  factory Npc.newNpc(int id) {
    return Npc(
      id: id,
      race: '',
      size: 20.0,
      life: Life.empty(),
      damage: Damage.empty(),
      armor: Armor.empty(),
      position: const Offset(0, 0),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'damage': damage.toMap(),
      'armor': armor.toMap(),
      'positionDx': position.dx,
      'positionDy': position.dy,
    };
  }

  factory Npc.fromMap(Map<String, dynamic>? data) {
    return Npc(
      id: data?['id'],
      race: data?['race'],
      size: data?['size'] * 1.0,
      life: Life.fromMap(data?['life']),
      damage: Damage.fromMap(data?['damage']),
      armor: Armor.fromMap(data?['armor']),
      position: Offset(data?['positionDx'] * 1.0, data?['positionDy'] * 1.0),
    );
  }

  void changePosition(Offset newPosition) {
    position = newPosition;
    update();
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('npcs')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('npcs')
        .doc(id.toString())
        .set(toMap());
  }
}
