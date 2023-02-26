import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';
import '../combat/damage.dart';

class Npc {
  int id;
  String race;
  double size;
  Life life;
  Armor armor;
  Power power;
  Movement movement;
  Vision vision;
  Position position;
  List<Attack> attacks;

  Npc({
    required this.id,
    required this.race,
    required this.size,
    required this.life,
    required this.armor,
    required this.power,
    required this.movement,
    required this.vision,
    required this.position,
    required this.attacks,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attacks) => attacks.toMap()).toList();

    return {
      'id': id,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'armor': armor.toMap(),
      'power': power.toMap(),
      'movement': movement.toMap(),
      'vision': vision.toMap(),
      'position': position.toMap(),
      'attacks': attacksToMap,
    };
  }

  factory Npc.fromMap(Map<String, dynamic>? data) {
    List<Attack> getAttacks = [];
    List<dynamic> attacksMap = data?['attacks'];

    for (var attack in attacksMap) {
      getAttacks.add(Attack.fromMap(attack));
    }

    return Npc(
      id: data?['id'],
      race: data?['race'],
      size: data?['size'] * 1.0,
      life: Life.fromMap(data?['life']),
      armor: Armor.fromMap(data?['armor']),
      power: Power.fromMap(data?['power']),
      movement: Movement.fromMap(data?['movement']),
      vision: Vision.fromMap(data?['vision']),
      position: Position.fromMap(data?['position']),
      attacks: getAttacks,
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

  void receiveAttack(Damage attackDamage, int rawDamage) {
    int leftOverArmor = 0;

    int pDamage = attackDamage.pDamage - armor.pArmor;
    if (pDamage < 0) {
      leftOverArmor += pDamage.abs();
      pDamage = 0;
    }
    int mDamage = attackDamage.mDamage - armor.mArmor;
    if (mDamage < 0) {
      leftOverArmor += mDamage.abs();
      mDamage = 0;
    }

    int totalDamage = pDamage + mDamage + rawDamage - leftOverArmor;

    life.receiveDamage(totalDamage);
    update();
  }
}
