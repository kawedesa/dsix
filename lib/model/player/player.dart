import 'dart:math';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/attribute/attributes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/effect/effect.dart';
import 'package:dsix/model/effect/effect_controller.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/player/equipment/player_equipment.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:flutter/material.dart';
import '../combat/position.dart';

class Player {
  String id;
  String name;
  String race;
  String sex;
  double size;
  Life life;
  Position position;
  Attributes attributes;
  PlayerEquipment equipment;
  EffectController effects;
  bool ready;

  Player(
      {required this.id,
      required this.name,
      required this.race,
      required this.sex,
      required this.size,
      required this.life,
      required this.position,
      required this.attributes,
      required this.equipment,
      required this.effects,
      required this.ready});

  final database = FirebaseFirestore.instance;

  factory Player.empty() {
    return Player(
      id: '',
      name: '',
      race: '',
      sex: '',
      size: 0,
      life: Life.empty(),
      position: Position.empty(),
      attributes: Attributes.empty(),
      equipment: PlayerEquipment.empty(),
      effects: EffectController.empty(),
      ready: false,
    );
  }

  factory Player.newPlayer(String id) {
    return Player(
      id: id,
      name: '',
      race: '',
      sex: '',
      size: 15,
      life: Life.empty(),
      position: Position.empty(),
      attributes: Attributes.empty(),
      equipment: PlayerEquipment.empty(),
      effects: EffectController.empty(),
      ready: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'race': race,
      'sex': sex,
      'size': size,
      'life': life.toMap(),
      'position': position.toMap(),
      'attributes': attributes.toMap(),
      'equipment': equipment.toMap(),
      'effects': effects.toMap(),
      'ready': ready,
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    return Player(
      id: data?['id'],
      name: data?['name'],
      race: data?['race'],
      sex: data?['sex'],
      size: data?['size'],
      life: Life.fromMap(data?['life']),
      position: Position.fromMap(data?['position']),
      attributes: Attributes.fromMap(data?['attributes']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      effects: EffectController.fromMap(data?['effects']),
      ready: data?['ready'],
    );
  }

  void setRace(String race, String sex) {
    this.race = race;
    this.sex = sex;
    life.setLife(race);
    attributes.setRaceAttributes(race);
    equipment.setWeight(race);
    update();
  }

  void chooseName(String name) {
    this.name = name;
  }

  void iAmReady() {
    ready = true;
    update();
  }

  void iAmNotReady() {
    ready = false;
    update();
  }

  void passTurn() {
    checkEffects();
    attributes.defense.resetTempDefense();
    attributes.vision.resetTempVision();
    update();
  }

  void newRound() {
    position.reset();
    life.reset();
    ready = false;
    resetEffects();
    update();
  }

  void spawn(Position spawnerPosition, double spawnerSize) {
    double dx = spawnerPosition.dx +
        Random().nextDouble() * spawnerSize -
        spawnerSize / 2;
    double dy = spawnerPosition.dy +
        Random().nextDouble() * spawnerSize -
        spawnerSize / 2;
    position.dx = dx;
    position.dy = dy;
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

  Path getHitBoxWithPositionOffset() {
    Path hitBox = getHitBox();
    hitBox = hitBox.shift(position.getOffset());
    return hitBox;
  }

  Path getHitBox() {
    Path hitBox = Path();
    hitBox = Path()
      ..addRect(Rect.fromPoints(const Offset(2.5, 0), const Offset(-2.5, -10)));

    return hitBox;
  }

  bool inActionArea(Path attackArea) {
    if (attackArea.computeMetrics().isEmpty) {
      return false;
    }

    Path intersection = Path.combine(
        PathOperation.intersect, getHitBoxWithPositionOffset(), attackArea);

    if (intersection.computeMetrics().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Attack attack(Attack attack) {
    Attack playerAttack = attack;

    if (effects.isWeaken()) {
      playerAttack.damage.rawDamage = attributes.power.getRawDamage() ~/ 2;
    } else {
      playerAttack.damage.rawDamage = attributes.power.getRawDamage();
    }

    return playerAttack;
  }

  void reload(Attack attack) {
    attack.reload();
    update();
  }

  void unload(Attack attack) {
    attack.unload();
    update();
  }

  void heal(int healAmount) {
    life.heal(healAmount);
    update();
  }

  int receiveAttack(Attack attack) {
    int pArmor = equipment.getPArmor();
    int mArmor = equipment.getMArmor();
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
        if (checkEffect.name == effect) {
          checkEffect.increaseCountdown();
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
      case 'heal':
        life.heal(1);
        break;
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
      case 'weaken':
        attributes.power.removeAttribute();
        effects.currentEffects
            .add(Effect(name: effect, description: '', value: 0, countdown: 1));
        break;
      case 'spiky':
        effects.onBeignHitEffects.add('thorn');
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
      removeEffect(effect.name);
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
      case 'weaken':
        effect.decreaseCountdown();
        break;
    }
  }

  void removeEffect(String effect) {
    switch (effect) {
      case 'poison':
        effects.removeEffect(effect);
        break;
      case 'burn':
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
      case 'weaken':
        attributes.power.addAttribute();
        effects.removeEffect(effect);
        break;
      case 'spiky':
        effects.onBeignHitEffects.remove('thorn');
        break;
    }
  }

  void resetEffects() {
    effects.resetCurrentEffects();
    checkEffects();
    update();
  }

  //EQUIPMENT
  void quickEquip(EquipmentSlot slot) {
    if (slot.name != 'bag') {
      unequip(slot);
      update();
    }

    switch (slot.item.itemSlot) {
      case 'one hand':
        if (equipment.mainHandSlot.isEquipped() &&
            equipment.offHandSlot.isEmpty()) {
          removeItemFromBag(slot.item);
          equip(equipment.offHandSlot, slot.item);
        } else {
          removeItemFromBag(slot.item);
          equip(equipment.mainHandSlot, slot.item);
        }
        break;
      case 'two hands':
        removeItemFromBag(slot.item);
        equip(equipment.mainHandSlot, slot.item);
        break;
      case 'head':
        removeItemFromBag(slot.item);
        equip(equipment.headSlot, slot.item);
        break;
      case 'body':
        removeItemFromBag(slot.item);
        equip(equipment.bodySlot, slot.item);
        break;
      case 'hands':
        removeItemFromBag(slot.item);
        equip(equipment.handSlot, slot.item);
        break;
      case 'feet':
        removeItemFromBag(slot.item);
        equip(equipment.feetSlot, slot.item);
        break;
    }
  }

  void equip(EquipmentSlot slot, Item item) {
    if (item.itemSlot == 'two hands') {
      unequip(equipment.mainHandSlot);
      unequip(equipment.offHandSlot);
      addItemEffects(item.effects);
      equipment.mainHandSlot.equip(item);
      equipment.offHandSlot.equip(item);
    } else {
      unequip(slot);
      addItemEffects(item.effects);

      slot.equip(item);
    }
    update();
  }

  void switchEquipments() {
    Item tempItem = equipment.mainHandSlot.item;
    equipment.mainHandSlot.item = equipment.offHandSlot.item;
    equipment.offHandSlot.item = tempItem;
    update();
  }

  void unequip(EquipmentSlot slot) {
    if (slot.isEmpty()) {
      return;
    }

    if (slot.item.itemSlot == 'two hands') {
      removeItemEffects(slot.item.effects);
      equipment.addItemToBag(equipment.mainHandSlot.item);
      equipment.mainHandSlot.unequip();
      equipment.offHandSlot.unequip();
      return;
    }
    removeItemEffects(slot.item.effects);
    equipment.addItemToBag(slot.item);
    slot.unequip();
  }

  void addItemEffects(List<String> effects) {
    for (String effect in effects) {
      applyNewEffect(effect);
    }
  }

  void removeItemEffects(List<String> effects) {
    for (String effect in effects) {
      removeEffect(effect);
    }
  }

  void addItemToBag(EquipmentSlot slot) {
    if (slot.name == 'loot') {
      equipment.addItemWeight(slot.item.weight);
      equipment.addItemToBag(slot.item);
      update();
      return;
    }
    unequip(slot);
    update();
  }

  void removeItemFromBag(Item item) {
    equipment.removeItemFromBag(item);
    update();
  }

  void addGold(int value) {
    equipment.addGold(value);
    update();
  }

  void buyItem(Item item) {
    equipment.removeGold(item.value);
    equipment.addItemWeight(item.weight);
    equipment.addItemToBag(item);
    update();
  }

  void sellItem(EquipmentSlot slot) {
    Item tempItem = slot.item;
    int itemValue = tempItem.value ~/ 2;

    if (slot.name != 'bag') {
      unequip(slot);
    }

    equipment.addGold(itemValue);
    equipment.removeItemWeight(tempItem.weight);
    equipment.removeItemFromBag(tempItem);
    update();
    throw ItemSoldException('+ \$$itemValue');
  }

  Path getVisionArea() {
    return Path()
      ..addOval(Rect.fromCircle(
          center: Offset(position.dx, position.dy),
          radius: attributes.vision.getRange() / 2));
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(id)
        .set(toMap());
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('players')
        .doc(id)
        .update(toMap());
  }
}
