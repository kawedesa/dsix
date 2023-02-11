import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';
import '../combat/Armor.dart';
import '../combat/damage.dart';

class Npc {
  int id;
  String race;
  double size;
  Life life;
  Damage damage;
  Armor armor;
  Position position;
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'damage': damage.toMap(),
      'armor': armor.toMap(),
      'position': position.toMap(),
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
      position: Position.fromMap(data?['position']),
    );
  }

  void changePosition(Position newPosition) {
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
