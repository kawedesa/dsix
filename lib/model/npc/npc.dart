import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';

import '../combat/ability/ability.dart';
import '../combat/damage.dart';

class Npc {
  int id;
  String race;
  double size;
  Life life;
  Damage damage;
  Armor armor;
  Movement movement;
  Vision vision;
  Position position;
  List<Ability> abilities;

  Npc({
    required this.id,
    required this.race,
    required this.size,
    required this.life,
    required this.damage,
    required this.armor,
    required this.movement,
    required this.vision,
    required this.position,
    required this.abilities,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var abilityToMap = abilities.map((ability) => ability.toMap()).toList();

    return {
      'id': id,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'damage': damage.toMap(),
      'armor': armor.toMap(),
      'movement': movement.toMap(),
      'vision': vision.toMap(),
      'position': position.toMap(),
      'abilities': abilityToMap,
    };
  }

  factory Npc.fromMap(Map<String, dynamic>? data) {
    List<Ability> getAbilities = [];
    List<dynamic> abilitiesMap = data?['abilities'];

    for (var ability in abilitiesMap) {
      getAbilities.add(Ability.fromMap(ability));
    }

    return Npc(
      id: data?['id'],
      race: data?['race'],
      size: data?['size'] * 1.0,
      life: Life.fromMap(data?['life']),
      damage: Damage.fromMap(data?['damage']),
      armor: Armor.fromMap(data?['armor']),
      movement: Movement.fromMap(data?['movement']),
      vision: Vision.fromMap(data?['vision']),
      position: Position.fromMap(data?['position']),
      abilities: getAbilities,
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

  void receiveAttack(Damage rawDamage) {
    int damageAfterArmor = calculateDamage(rawDamage);

    life.receiveDamage(damageAfterArmor);
    update();
  }

  int calculateDamage(Damage rawDamage) {
    int pDamage = rawDamage.pDamage - armor.pArmor;
    if (pDamage < 0) {
      pDamage = 0;
    }
    int mDamage = rawDamage.mDamage - armor.mArmor;
    if (mDamage < 0) {
      mDamage = 0;
    }

    int totalDamage = pDamage + mDamage;

    print(totalDamage);

    return totalDamage;
  }
}
