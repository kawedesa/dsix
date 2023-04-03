import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/attribute.dart';
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
  Attribute attributes;
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
    required this.attributes,
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
      'attributes': attributes.toMap(),
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
      attributes: Attribute.fromMap(data?['attributes']),
      position: Position.fromMap(data?['position']),
      attacks: getAttacks,
      effects: EffectController.fromMap(data?['effects']),
      loot: getLoot,
    );
  }

  void passTurn() {
    checkEffects();
    attributes.defense.resetTempDefense();
    attributes.vision.resetTempVision();
    update();
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  Attack attack(Attack attack) {
    Attack npcAttack = attack;

    npcAttack.damage.rawDamage = attributes.power.getRawDamage();

    return npcAttack;
  }

  int receiveAttack(Attack attack) {
    int pArmor = armor.pArmor;
    int mArmor = armor.mArmor;
    int leftOverArmor = 0;

    if (effects.isVulnerable()) {
      pArmor = pArmor ~/ 2;
      mArmor = mArmor ~/ 2;
    }

    if (attack.damage.pierce > 0) {
      pArmor -= attack.damage.pierce;
      mArmor -= attack.damage.pierce;

      if (pArmor < 0) {
        pArmor = 0;
      }
      if (mArmor < 0) {
        mArmor = 0;
      }
    }

    int pDamage = attack.damage.pDamage - pArmor;

    if (pDamage < 0) {
      leftOverArmor += pDamage.abs() ~/ 2;
      pDamage = 0;
    }

    int mDamage = attack.damage.mDamage - mArmor;

    if (mDamage < 0) {
      leftOverArmor += mDamage.abs() ~/ 2;
      mDamage = 0;
    }

    int leftOverRawDamage = attack.damage.rawDamage - leftOverArmor;
    int totalDamage = pDamage + mDamage + leftOverRawDamage;

    if (totalDamage > 0) {
      life.receiveDamage(totalDamage);
      receiveEffects(attack.effects);
    } else {
      totalDamage = 0;
      update();
    }

    return totalDamage;
  }

  void receiveEffects(List<String> incomingEffects) {
    for (String effect in incomingEffects) {
      int checker = 0;
      for (Effect checkEffect in effects.currentEffects) {
        if (checkEffect.name == effect && checkEffect.countdown > 0) {
          checkEffect.countdown++;
          checker++;
        }
      }
      if (checker == 0) {
        applyNewEffect(effect);
      }
    }

    update();
  }

  void applyNewEffect(String effect) {
    switch (effect) {
      case 'poison':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;

      case 'bleed':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'vulnerable':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 0, countdown: 1));
        break;

      case 'stun':
        attributes.movement.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 0, countdown: 1));
        break;
      case 'thorn':
        life.receiveDamage(1);
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
      removeEffects(effect);
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        effect.decreaseCountdown();
        life.receiveDamage(effect.value);
        break;
      case 'bleed':
        effect.decreaseCountdown();
        life.receiveDamage(effect.value);
        break;
      case 'vulnerable':
        effect.decreaseCountdown();
        break;
      case 'stun':
        effect.decreaseCountdown();
        break;
    }
  }

  void removeEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        effects.removeEffect(effect);
        break;
      case 'bleed':
        effects.removeEffect(effect);
        break;
      case 'vulnerable':
        effects.removeEffect(effect);
        break;
      case 'stun':
        attributes.movement.addAttribute();
        effects.removeEffect(effect);
        break;
    }
  }

  void createLoot() {
    int lootValue = 0;
    switch (xp) {
      case 4:
        lootValue = 50 + (Random().nextDouble() * 100).toInt();
        break;
      case 10:
        lootValue = 100 + (Random().nextDouble() * 150).toInt();
        break;
      case 14:
        lootValue = 150 + (Random().nextDouble() * 200).toInt();
        break;
    }
    loot = Shop().createRandomLoot(lootValue);
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

  Path getVisionArea() {
    Path area = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(position.dx, position.dy),
          radius: attributes.vision.getRange() / 2));

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
