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
import 'package:dsix/model/player/player.dart';
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

  factory Npc.empty() {
    return Npc(
      id: 0,
      xp: 0,
      name: '',
      size: 15,
      life: Life.empty(),
      armor: Armor.empty(),
      attributes: Attributes.empty(),
      position: Position.empty(),
      attacks: [],
      abilities: [],
      effects: EffectController.empty(),
      loot: [],
    );
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

  void passTurn(List<Player> players, List<Npc> npcs) {
    checkEffectsOnPassTurn();

    if (life.isDead()) {
      die(players, npcs);
    }
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
  }

  void changePosition(Position newPosition) {
    position = newPosition;
  }

  void knockBack(Position actionCenter) {
    position.knockBack(actionCenter);
  }

  void defend() {
    attributes.defense.defend();
  }

  void look() {
    attributes.vision.look();
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
  }

  void reload(Attack attack) {
    attack.reload();
  }

  void heal(int healAmount) {
    life.heal(healAmount);
  }

  List<int> receiveAttack(Attack attack) {
    List<int> armorAndLifeDamage = [];

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

    int lifeDamage = totalDamageAfterEquip - attributes.defense.tempArmor;

    int armorDamage = attributes.defense.tempArmor;

    attributes.defense.reduceTempArmor(totalDamageAfterEquip);
    armorDamage = attributes.defense.tempArmor - armorDamage;

    if (lifeDamage > 0) {
      life.receiveDamage(lifeDamage);
    } else {
      lifeDamage = 0;
    }

    armorAndLifeDamage.add(armorDamage);
    armorAndLifeDamage.add(lifeDamage);

    return armorAndLifeDamage;
  }

  void die(List<Player> players, List<Npc> npcs) {
    onDeathEffects(players, npcs);
    resetEffects();
    createLoot();
  }

  void onDeathEffects(List<Player> players, List<Npc> npcs) {
    for (String effect in effects.onDeath) {
      switch (effect) {
        case 'baby death':
          for (Npc npc in npcs) {
            if (npc.name != 'mama bear' ||
                position.getDistanceFromPosition(npc.position) > 100) {
              continue;
            }
            npc.receiveEffects([
              'rage',
              'rage',
              'rage',
            ]);
            npc.update();
          }
          break;
      }
    }
    effects.onDeath = [];
  }

  void resetEffects() {
    effects.resetCurrentEffects();
    markEffectsToRemove();
  }

  void markEffectsToRemove() {
    List<Effect> effectsToRemove = [];

    for (Effect effect in effects.currentEffects) {
      if (effects.markEffectToRemove(effect)) {
        effectsToRemove.add(effect);
      }
    }
    for (Effect effect in effectsToRemove) {
      removeEffects(effect);
    }
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
  }

  void onDamageEffects() {
    if (effects.onDamage.isEmpty) {
      return;
    }
    for (String effect in effects.onDamage) {
      switch (effect) {
        case 'cry':
          receiveEffects([effect]);
          break;
        case 'vanish':
          changePosition(Position.empty());
          break;
      }
    }
  }

  void applyNewEffect(String effect) {
    Effect applyEffect = Effect(name: effect, value: 1, countdown: 1);

    switch (effect) {
      case 'bleed':
        effects.currentEffects.add(applyEffect);
        break;
      case 'blind':
        attributes.vision.removeAttribute();
        effects.currentEffects.add(applyEffect);
        break;
      case 'burn':
        effects.currentEffects.add(applyEffect);
        break;
      case 'cry':
        if (effects.auras.contains('cry') == false) {
          effects.auras.add('cry');
        }
        effects.currentEffects.add(applyEffect);
        break;
      case 'empower':
        attributes.power.addAttribute();
        effects.currentEffects.add(applyEffect);
        break;
      case 'illusion':
        effects.currentEffects.add(applyEffect);
        break;
      case 'poison':
        effects.currentEffects.add(applyEffect);
        break;

      case 'rage':
        attributes.power.addAttribute();
        attributes.movement.addAttribute();
        attributes.defense.removeAttribute();
        attributes.defense.removeAttribute();
        effects.currentEffects.add(applyEffect);
        break;
      case 'slow':
        attributes.movement.removeAttribute();
        effects.currentEffects.add(applyEffect);
        break;

      case 'stun':
        attributes.movement.removeAttribute();
        effects.currentEffects.add(applyEffect);
        break;

      case 'vulnerable':
        effects.currentEffects.add(applyEffect);
        break;

      case 'weaken':
        attributes.power.removeAttribute();
        effects.currentEffects.add(applyEffect);
        break;
    }
  }

  void triggerEffects(Effect effect) {
    switch (effect.name) {
      case 'bleed':
        effect.decreaseCountdown();
        life.receiveDamage(1);

        break;
      case 'blind':
        effect.decreaseCountdown();
        break;
      case 'burn':
        effect.decreaseCountdown();
        life.receiveDamage(1);

        break;
      case 'cry':
        effect.decreaseCountdown();
        break;
      case 'empower':
        effect.decreaseCountdown();
        break;

      case 'illusion':
        effect.decreaseCountdown();
        break;

      case 'poison':
        effect.decreaseCountdown();
        life.receiveDamage(1);

        break;
      case 'rage':
        effect.decreaseCountdown();
        break;
      case 'slow':
        effect.decreaseCountdown();
        break;
      case 'stun':
        effect.decreaseCountdown();
        break;

      case 'vulnerable':
        effect.decreaseCountdown();
        break;
      case 'weaken':
        effect.decreaseCountdown();
        break;
    }
  }

  void removeEffects(Effect effect) {
    switch (effect.name) {
      case 'bleed':
        effects.removeEffect(effect);

        break;
      case 'blind':
        attributes.vision.addAttribute();
        effects.removeEffect(effect);

        break;
      case 'burn':
        effects.removeEffect(effect);

        break;

      case 'cry':
        effects.auras.remove('cry');
        effects.removeEffect(effect);

        break;
      case 'empower':
        attributes.power.removeAttribute();
        effects.removeEffect(effect);

        break;
      case 'illusion':
        changePosition(Position.empty());
        effects.removeEffect(effect);

        break;

      case 'rage':
        attributes.power.removeAttribute();
        attributes.movement.removeAttribute();
        attributes.defense.addAttribute();
        attributes.defense.addAttribute();
        effects.removeEffect(effect);

        break;
      case 'poison':
        effects.removeEffect(effect);

        break;

      case 'slow':
        attributes.movement.addAttribute();
        effects.removeEffect(effect);

        break;
      case 'stun':
        attributes.movement.addAttribute();
        effects.removeEffect(effect);

        break;
      case 'vulnerable':
        effects.removeEffect(effect);

        break;
      case 'weaken':
        attributes.power.addAttribute();
        effects.removeEffect(effect);

        break;

      case 'spiky':
        effects.onHit.remove('thorn');

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
    loot = Shop().createLoot(lootValue, 'normal');
  }

  void addItemToLoot(Item item) {
    loot.add(item);
  }

  void removeItemFromLoot(Item item) {
    loot.remove(item);
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
