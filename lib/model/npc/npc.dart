import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/effect_controller.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:flutter/material.dart';

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
  EffectController effects;

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
    required this.effects,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attack) => attack.toMap()).toList();

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
      'effects': effects.toMap(),
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
      effects: EffectController.fromMap(data?['effects']),
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

  Attack attack(Attack attack) {
    Attack npcAttack = attack;

    npcAttack.damage.rawDamage = power.getRawDamage();

    return npcAttack;
  }

  void receiveAttack(Attack attack) {
    int leftOverArmor = 0;

    int pDamage = attack.damage.pDamage - armor.pArmor;
    if (pDamage < 0) {
      leftOverArmor += pDamage.abs() ~/ 2;
      pDamage = 0;
    }
    int mDamage = attack.damage.mDamage - armor.mArmor;
    if (mDamage < 0) {
      leftOverArmor += mDamage.abs() ~/ 2;
      mDamage = 0;
    }

    int leftOverRawDamage = attack.damage.rawDamage - leftOverArmor;

    // int leftOverDamageAfterTempArmor =
    //     leftOverRawDamage - attributes.defense.tempDefense;

    // attributes.defense.reduceTempArmor(leftOverRawDamage);
    // if (attributes.defense.tempDefense > 0) {
    //   effects.applyNewEffect(attributes.defense.getTempArmorEffect());
    // }

    // if (leftOverDamageAfterTempArmor < 1) {
    //   leftOverDamageAfterTempArmor = 0;
    // }

    int totalDamage = pDamage + mDamage + leftOverRawDamage;

    if (totalDamage < 1) {
      totalDamage = 0;
    }

    life.receiveDamage(totalDamage);

    if (totalDamage > 0) {
      receiveEffect(attack.onHitEffect);
    }

    update();
  }

  void receiveEffect(Effect incomingEffect) {
    for (Effect effect in effects.currentEffects) {
      if (effect.name == incomingEffect.name && effect.countdown > 0) {
        effect.countdown++;

        return;
      }
    }

    try {
      effects.applyNewEffect(incomingEffect);
    } on TakeDamageException catch (effect) {
      life.receiveDamage(effect.damage);
    }
  }

  void passTurn() {
    effects.checkEffects();
    // attributes.defense.resetTempDefense();
    // attributes.vision.resetTempVision();
    update();
  }

  Path getVisionArea() {
    Path area = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(position.dx, position.dy),
          radius: vision.getRange() / 2));

    return area;
  }
}
