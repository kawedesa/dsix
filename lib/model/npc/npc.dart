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
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/shop.dart';
import 'package:flutter/material.dart';

class Npc {
  int id;
  int xp;
  String name;
  double size;
  Life life;
  Armor armor;
  Power power;
  Movement movement;
  Vision vision;
  Position position;
  List<Attack> attacks;
  EffectController effects;
  List<Item> loot;

  Npc({
    required this.id,
    required this.xp,
    required this.name,
    required this.size,
    required this.life,
    required this.armor,
    required this.power,
    required this.movement,
    required this.vision,
    required this.position,
    required this.attacks,
    required this.effects,
    required this.loot,
  });

  final database = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attack) => attack.toMap()).toList();
    var lootToMap = loot.map((item) => item.toMap()).toList();
    return {
      'id': id,
      'xp': xp,
      'name': name,
      'size': size,
      'life': life.toMap(),
      'armor': armor.toMap(),
      'power': power.toMap(),
      'movement': movement.toMap(),
      'vision': vision.toMap(),
      'position': position.toMap(),
      'attacks': attacksToMap,
      'effects': effects.toMap(),
      'loot': lootToMap,
    };
  }

  factory Npc.fromMap(Map<String, dynamic>? data) {
    List<Attack> getAttacks = [];
    List<dynamic> attacksMap = data?['attacks'];
    for (var attack in attacksMap) {
      getAttacks.add(Attack.fromMap(attack));
    }

    List<Item> getLoot = [];
    List<dynamic> lootMap = data?['loot'];
    for (var item in lootMap) {
      getLoot.add(Item.fromMap(item));
    }

    return Npc(
      id: data?['id'],
      xp: data?['xp'],
      name: data?['name'],
      size: data?['size'] * 1.0,
      life: Life.fromMap(data?['life']),
      armor: Armor.fromMap(data?['armor']),
      power: Power.fromMap(data?['power']),
      movement: Movement.fromMap(data?['movement']),
      vision: Vision.fromMap(data?['vision']),
      position: Position.fromMap(data?['position']),
      attacks: getAttacks,
      effects: EffectController.fromMap(data?['effects']),
      loot: getLoot,
    );
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
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

    // if (leftOverDamageAfterTempArmor < 1) {
    //   leftOverDamageAfterTempArmor = 0;
    // }

    int totalDamage = pDamage + mDamage + leftOverRawDamage;

    if (totalDamage > 0) {
      receiveEffect(attack.onHitEffect);
    }

    life.receiveDamage(totalDamage);

    update();
  }

  void createLoot() {
    loot = Shop().createRandomLoot(xp);
    update();
  }

  void addItemToLoot(Item item) {
    loot.add(item);
    update();
  }

  void removeItemFromLoot(Item item) {
    loot.remove(item);
    update();
  }

  void receiveEffect(Effect incomingEffect) {
    for (Effect effect in effects.currentEffects) {
      if (effect.name == incomingEffect.name && effect.countdown > 0) {
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
        effects.currentEffects.add(effect);
        break;
      case 'thorn':
        life.receiveDamage(effect.value);
        break;
      case 'bleed':
        effects.currentEffects.add(effect);
        break;
    }
  }

  void checkEffects() {
    List<Effect> effectsToRemove = [];

    for (Effect effect in effects.currentEffects) {
      triggerEffects(effect);
      if (effects.markEffectToRemove(effect)) {
        effectsToRemove.add(effect);
      }
    }

    for (Effect effect in effectsToRemove) {
      effects.removeEffect(effect);
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        effect.countdown--;
        life.receiveDamage(effect.value);
        break;
      case 'bleed':
        effect.countdown--;
        life.receiveDamage(effect.value);
        break;
    }
  }

  void passTurn() {
    checkEffects();

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

  void delete() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('npcs')
        .doc(id.toString())
        .delete();
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
