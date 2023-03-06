import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/movement.dart';
import 'package:dsix/model/combat/attribute/power.dart';
import 'package:dsix/model/combat/attribute/vision.dart';
import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/passive_effects.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/model/combat/position.dart';
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
  PassiveEffects passiveEffects;
  List<Effect> currentEffects;

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
    required this.passiveEffects,
    required this.currentEffects,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attack) => attack.toMap()).toList();
    var currentEffectsMap =
        currentEffects.map((effect) => effect.toMap()).toList();

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
      'passiveEffects': passiveEffects.toMap(),
      'currentEffects': currentEffectsMap,
    };
  }

  factory Npc.fromMap(Map<String, dynamic>? data) {
    List<Attack> getAttacks = [];
    List<dynamic> attacksMap = data?['attacks'];
    for (var attack in attacksMap) {
      getAttacks.add(Attack.fromMap(attack));
    }

    List<Effect> getCurrentEffects = [];
    List<dynamic> currentEffectsMap = data?['currentEffects'];
    for (var effect in currentEffectsMap) {
      getCurrentEffects.add(Effect.fromMap(effect));
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
      passiveEffects: PassiveEffects.fromMap(data?['passiveEffects']),
      currentEffects: getCurrentEffects,
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

    if (leftOverRawDamage < 1) {
      leftOverRawDamage = 0;
    }

    int totalDamage = pDamage + mDamage + leftOverRawDamage;

    if (totalDamage < 1) {
      totalDamage = 0;
    }

    life.receiveDamage(totalDamage);

    if (totalDamage < 0) {
      update();
    } else {
      receiveEffect(attack.onHitEffect);
    }
  }

  void receiveEffect(Effect incomingEffect) {
    for (Effect effect in currentEffects) {
      if (effect.name == incomingEffect.name) {
        effect.countdown++;
        update();
        return;
      }
    }

    applyNewEffect(incomingEffect);
    update();
  }

  void applyNewEffect(Effect effect) {
    switch (effect.name) {
      case 'poison':
        currentEffects.add(effect);
        break;
      case 'thorn':
        life.receiveDamage(1);
        break;
    }
  }

  // void triggerAfterAttackEffect() {
  //   triggerEffects(passiveEffects.afterAttackEffect);
  //   update();
  // }

  void passTurn() {
    checkEffects();
    update();
  }

  void checkEffects() {
    List<Effect> effectsToRemove = [];

    for (Effect effect in currentEffects) {
      triggerEffects(effect);
      if (markEffectToRemove(effect)) {
        effectsToRemove.add(effect);
      }
    }

    for (Effect effect in effectsToRemove) {
      removeEffect(effect);
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        life.receiveDamage(effect.value);
        effect.countdown--;
        break;
      case 'heal':
        life.heal(effect.value);
        break;
    }
  }

  bool markEffectToRemove(Effect effect) {
    if (effect.countdown > 0) {
      return false;
    } else {
      return true;
    }
  }

  void removeEffect(Effect effect) {
    currentEffects.remove(effect);
  }

  Path getVisionArea() {
    Path area = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(position.dx, position.dy),
          radius: vision.getRange() / 2));

    return area;
  }
}
