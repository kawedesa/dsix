import 'dart:math';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/attribute/attribute.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/effect.dart';
import 'package:dsix/model/player/equipment/player_equipment.dart';
import 'package:dsix/model/combat/life.dart';
import '../combat/damage.dart';
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
  List<Effect> appliedEffects;
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
      required this.appliedEffects,
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
      appliedEffects: [],
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
      appliedEffects: [],
      ready: false,
    );
  }

  Map<String, dynamic> toMap() {
    var effectsToMap = appliedEffects.map((effect) => effect.toMap()).toList();

    return {
      'id': id,
      'name': name,
      'race': race,
      'size': size,
      'life': life.toMap(),
      'position': position.toMap(),
      'attributes': attributes.toMap(),
      'equipment': equipment.toMap(),
      'appliedEffects': effectsToMap,
      'ready': ready,
    };
  }

  factory Player.fromMap(Map<String, dynamic>? data) {
    List<Effect> getAppliedEffects = [];
    List<dynamic> appliedEffectsMap = data?['appliedEffects'];
    for (var effect in appliedEffectsMap) {
      getAppliedEffects.add(Effect.fromMap(effect));
    }

    return Player(
      id: data?['id'],
      name: data?['name'],
      race: data?['race'],
      size: data?['size'],
      life: Life.fromMap(data?['life']),
      position: Position.fromMap(data?['position']),
      attributes: Attribute.fromMap(data?['attributes']),
      equipment: PlayerEquipment.fromMap(data?['equipment']),
      appliedEffects: getAppliedEffects,
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

    if (leftOverRawDamage < 1) {
      leftOverRawDamage = 0;
    }

    int totalDamage = pDamage + mDamage + leftOverRawDamage;

    if (totalDamage < 1) {
      totalDamage = 0;
    }

    life.receiveDamage(totalDamage);

    //Apply Effects

    if (attack.onHitEffects.isNotEmpty) {
      print('apply effect');
    }

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

  bool canSee(Position position) {
    double distance = this.position.getDistanceFromPosition(position);

    if (distance > attributes.vision.getRange() / 2) {
      return false;
    } else {
      return true;
    }
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
