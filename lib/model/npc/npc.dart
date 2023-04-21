import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/ability.dart';
import 'package:dsix/model/combat/armor.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/attributes/attributes.dart';
import 'package:dsix/model/combat/hit_box.dart';
import 'package:dsix/model/effect/effect.dart';
import 'package:dsix/model/effect/effect_controller.dart';
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
  Attributes attributes;
  Position position;
  List<Attack> attacks;
  List<Ability> abilities;
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
    required this.abilities,
    required this.effects,
    required this.loot,
  });

  final database = FirebaseFirestore.instance;
  HitBox hitBox = HitBox();

  Map<String, dynamic> toMap() {
    var attacksToMap = attacks.map((attack) => attack.toMap()).toList();
    var abilitiesToMap = abilities.map((ability) => ability.toMap()).toList();
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
      'abilities': abilitiesToMap,
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

    List<Ability> getAbilities = [];
    List<dynamic> abilitiesMap = data?['abilities'];
    for (var ability in abilitiesMap) {
      getAbilities.add(Ability.fromMap(ability));
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
      attributes: Attributes.fromMap(data?['attributes']),
      position: Position.fromMap(data?['position']),
      attacks: getAttacks,
      abilities: getAbilities,
      effects: EffectController.fromMap(data?['effects']),
      loot: getLoot,
    );
  }

  void passTurn() {
    resetTemporaryAttributes();
    checkEffectsOnPassTurn();
  }

  void checkEffectsOnPassTurn() {
    for (Effect effect in effects.currentEffects) {
      triggerEffects(effect);
    }
    markEffectsToRemove();
  }

  void resetTemporaryAttributes() {
    attributes.defense.resetTempDefense();
    attributes.vision.resetTempVision();
    update();
  }

  void changePosition(Position newPosition) {
    position = newPosition;
    update();
  }

  void knockBack(Position actionCenter) {
    position.knockBack(actionCenter);
    update();
  }

  void defend() {
    attributes.defense.defend();

    update();
  }

  void look() {
    attributes.vision.look();

    update();
  }

  void die() {
    resetEffects();
    createLoot();
    update();
  }

  bool inActionArea(Path attackArea) {
    if (attackArea.computeMetrics().isEmpty) {
      return false;
    }

    Path intersection = Path.combine(PathOperation.intersect,
        hitBox.getWithPositionOffset(name, position.getOffset()), attackArea);

    if (intersection.computeMetrics().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Attack attack(Attack attack) {
    Attack npcAttack = attack;

    if (effects.isWeaken()) {
      npcAttack.damage.rawDamage = attributes.power.getRawDamage() ~/ 2;
    } else {
      npcAttack.damage.rawDamage = attributes.power.getRawDamage();
    }

    return npcAttack;
  }

  void unload(Attack attack) {
    attack.unload();
    update();
  }

  void reload(Attack attack) {
    attack.reload();
    update();
  }

  void heal(int healAmount) {
    life.heal(healAmount);
    update();
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

    if (leftOverRawDamage < 0) {
      leftOverRawDamage = 0;
    }

    int totalDamageAfterEquip = pDamage + mDamage + leftOverRawDamage;

    int totalDamage = totalDamageAfterEquip - attributes.defense.tempArmor;
    attributes.defense.reduceTempArmor(totalDamageAfterEquip);

    if (totalDamage > 0) {
      life.receiveDamage(totalDamage);
    } else {
      totalDamage = 0;
    }

    update();

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

  void onDamageEffects() {
    if (effects.onDamage.isEmpty) {
      return;
    }

    for (String effect in effects.onDamage) {
      switch (effect) {
        case 'cry':
          effects.auras.add('cry');
          effects.currentEffects.add(
              Effect(name: effect, description: '', value: 1, countdown: 3));
          update();
          break;
        case 'vanish':
          delete();
          break;
      }
    }
  }

  void applyNewEffect(String effect) {
    switch (effect) {
      case 'poison':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'burn':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;

      case 'bleed':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'vulnerable':
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;

      case 'stun':
        attributes.movement.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'slow':
        attributes.movement.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;

      case 'weaken':
        attributes.power.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'empower':
        attributes.power.addAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'blind':
        attributes.vision.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 1, countdown: 1));
        break;
      case 'spiky':
        effects.onHit.add('thorn');
        break;
    }
  }

  void markEffectsToRemove() {
    List<Effect> effectsToRemove = [];

    for (Effect effect in effects.currentEffects) {
      if (effects.markEffectToRemove(effect)) {
        effectsToRemove.add(effect);
      }
    }
    for (Effect effect in effectsToRemove) {
      removeEffects(effect.name);
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'poison':
        effect.decreaseCountdown();
        life.receiveDamage(effect.value);
        break;
      case 'burn':
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
      case 'slow':
        effect.decreaseCountdown();
        break;
      case 'weaken':
        effect.decreaseCountdown();
        break;
      case 'empower':
        effect.decreaseCountdown();
        break;
      case 'blind':
        effect.decreaseCountdown();
        break;
      case 'cry':
        effect.decreaseCountdown();
        break;
      case 'illusion':
        effect.decreaseCountdown();
        break;
    }
  }

  void removeEffects(String effect) {
    switch (effect) {
      case 'poison':
        effects.removeEffect(effect);
        update();
        break;
      case 'burn':
        effects.removeEffect(effect);
        update();
        break;
      case 'bleed':
        effects.removeEffect(effect);
        update();
        break;
      case 'vulnerable':
        effects.removeEffect(effect);
        update();
        break;
      case 'cry':
        effects.auras.remove('cry');
        effects.removeEffect(effect);
        update();
        break;
      case 'stun':
        attributes.movement.addAttribute();
        effects.removeEffect(effect);
        update();
        break;
      case 'slow':
        attributes.movement.addAttribute();
        effects.removeEffect(effect);
        update();
        break;
      case 'weaken':
        attributes.power.addAttribute();
        effects.removeEffect(effect);
        update();
        break;
      case 'empower':
        attributes.power.removeAttribute();
        effects.removeEffect(effect);
        update();
        break;
      case 'blind':
        attributes.vision.addAttribute();
        effects.removeEffect(effect);
        update();
        break;
      case 'spiky':
        effects.onHit.remove('thorn');
        update();
        break;
      case 'illusion':
        delete();
        break;
    }
  }

  void resetEffects() {
    effects.resetCurrentEffects();
    markEffectsToRemove();
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
