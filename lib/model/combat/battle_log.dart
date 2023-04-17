import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dsix/model/combat/attack_info.dart';

import 'package:dsix/model/combat/position.dart';

class BattleLog {
  int id;
  String message;
  Target attacker;
  AttackInfo attackInfo;
  List<Target> targets;

  BattleLog({
    required this.id,
    required this.message,
    required this.attacker,
    required this.attackInfo,
    required this.targets,
  });

  final database = FirebaseFirestore.instance;

  factory BattleLog.empty() {
    return BattleLog(
      id: 0,
      message: '',
      attacker: Target.empty(),
      attackInfo: AttackInfo.empty(),
      targets: [],
    );
  }

  factory BattleLog.fromMap(Map<String, dynamic>? data) {
    List<Target> getTargets = [];
    List<dynamic> targetsMap = data?['targets'];
    for (var target in targetsMap) {
      getTargets.add(Target.fromMap(target));
    }

    return BattleLog(
      id: data?['id'],
      message: data?['message'],
      attacker: Target.fromMap(data?['attacker']),
      attackInfo: AttackInfo.fromMap(data?['attackInfo']),
      targets: getTargets,
    );
  }

  Map<String, dynamic> toMap() {
    var targetToMap = targets.map((target) => target.toMap()).toList();

    return {
      'id': id,
      'message': message,
      'attacker': attacker.toMap(),
      'attackInfo': attackInfo.toMap(),
      'targets': targetToMap,
    };
  }

  void setAttacker(String id, Position position) {
    attacker = Target(
      id: id,
      position: position,
      lifeDamage: 0,
      armorDamage: 0,
    );
  }

  void addTarget(
      String targetId, Position position, int lifeDamage, int armorDamage) {
    targets.add(Target(
        id: targetId,
        position: position,
        lifeDamage: lifeDamage,
        armorDamage: armorDamage));
  }

  void setAttackInfo(AttackInfo info) {
    attackInfo = info;
  }

  void newBattleLog() {
    id = DateTime.now().millisecondsSinceEpoch;
    set();
  }

  void reset() {
    id = 0;
    message = '';
    attacker = Target.empty();
    attackInfo = AttackInfo.empty();
    targets = [];
  }

  void update() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('battleLog')
        .doc(id.toString())
        .set(toMap());
  }

  void set() async {
    await database
        .collection('game')
        .doc('gameID')
        .collection('battleLog')
        .doc(id.toString())
        .set(toMap());
  }
}

class Target {
  String id;

  Position position;
  int lifeDamage;
  int armorDamage;
  Target({
    required this.id,
    required this.position,
    required this.lifeDamage,
    required this.armorDamage,
  });

  factory Target.empty() {
    return Target(
      id: '',
      position: Position.empty(),
      lifeDamage: 0,
      armorDamage: 0,
    );
  }

  factory Target.fromMap(Map<String, dynamic>? data) {
    return Target(
      id: data?['id'],
      position: Position.fromMap(data?['position']),
      lifeDamage: data?['lifeDamage'],
      armorDamage: data?['armorDamage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position.toMap(),
      'lifeDamage': lifeDamage,
      'armorDamage': armorDamage,
    };
  }
}
