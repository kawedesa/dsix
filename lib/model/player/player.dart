import 'dart:math';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/attribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/model/combat/effect/effect_controller.dart';
import 'package:dsix/model/player/equipment/player_equipment.dart';
import 'package:dsix/model/combat/life.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:flutter/material.dart';
import '../combat/position.dart';

class Player {
  String id;
  String name;
  String race;
  double size;
  Life life;
  Position position;
  Attribute attributes;
  PlayerEquipment equipment;
  EffectController effects;
  bool ready;

  Player(
      {required this.id,
      required this.name,
      required this.race,
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
      size: 0,
      life: Life.empty(),
      position: Position.empty(),
      attributes: Attribute.empty(),
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
      size: 15,
      life: Life.empty(),
      position: Position.empty(),
      attributes: Attribute.empty(),
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
      size: data?['size'],
      life: Life.fromMap(data?['life']),
      position: Position.fromMap(data?['position']),
      attributes: Attribute.fromMap(data?['attributes']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      effects: EffectController.fromMap(data?['effects']),
      ready: data?['ready'],
    );
  }

  void setRace(String race) {
    this.race = race;
    life.setLife(race);
    attributes.setAttribute(race);
    equipment.setWeight(race);
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

  Attack attack(Attack attack) {
    Attack playerAttack = attack;

    playerAttack.damage.rawDamage = attributes.power.getRawDamage();

    return playerAttack;
  }

  void receiveAttack(Attack attack) {
    int leftOverArmor = 0;

    int pDamage = attack.damage.pDamage - equipment.getTotalArmor().pArmor;
    if (pDamage < 0) {
      leftOverArmor += pDamage.abs() ~/ 2;
      pDamage = 0;
    }
    int mDamage = attack.damage.mDamage - equipment.getTotalArmor().mArmor;
    if (mDamage < 0) {
      leftOverArmor += mDamage.abs() ~/ 2;
      mDamage = 0;
    }

    int leftOverRawDamage = attack.damage.rawDamage - leftOverArmor;

    int leftOverDamageAfterTempArmor =
        leftOverRawDamage - attributes.defense.tempDefense;

    attributes.defense.reduceTempArmor(leftOverRawDamage);
    if (attributes.defense.tempDefense > 0) {
      effects.applyNewEffect(attributes.defense.getTempArmorEffect());
    }

    if (leftOverDamageAfterTempArmor < 1) {
      leftOverDamageAfterTempArmor = 0;
    }

    int totalDamage = pDamage + mDamage + leftOverDamageAfterTempArmor;

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
    attributes.defense.resetTempDefense();
    attributes.vision.resetTempVision();
    update();
  }

  void defend() {
    attributes.defense.defend();
    effects.applyNewEffect(attributes.defense.getTempArmorEffect());
  }

  void look() {
    attributes.vision.look();
    update();
  }

  Path getVisionArea() {
    Path area = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(position.dx, position.dy),
          radius: attributes.vision.getRange() / 2));

    return area;
  }

  void preparePlayerForNewRound() {
    position.reset();
    life.reset();
    ready = false;
    update();
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
