import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/combat/range.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';

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

  void setAttacker(Npc? npc, Player? player) {
    if (npc != null) {
      attacker = Target(
          id: npc.id.toString(),
          type: 'npc',
          position: npc.position,
          damage: 0);
    }

    if (player != null) {
      attacker = Target(
          id: player.id.toString(),
          type: 'player',
          position: player.position,
          damage: 0);
    }
  }

  void addTarget(String targetId, String type, Position position, int damage) {
    targets.add(
        Target(id: targetId, type: type, position: position, damage: damage));
  }

  void setAttackInfo(String name, double angle, double distance,
      Position actionCenter, Damage damage, Range range) {
    attackInfo = AttackInfo(
        name: name,
        angle: angle,
        distance: distance,
        actionCenter: actionCenter,
        damage: damage,
        range: range);
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

class AttackInfo {
  String name;
  double angle;
  double distance;
  Position actionCenter;
  Damage damage;
  Range range;
  AttackInfo(
      {required this.name,
      required this.angle,
      required this.distance,
      required this.actionCenter,
      required this.damage,
      required this.range});

  factory AttackInfo.empty() {
    return AttackInfo(
      name: '',
      angle: 0,
      distance: 0,
      actionCenter: Position.empty(),
      damage: Damage.empty(),
      range: Range.empty(),
    );
  }

  factory AttackInfo.fromMap(Map<String, dynamic>? data) {
    return AttackInfo(
      name: data?['name'],
      angle: data?['angle'],
      distance: data?['distance'],
      actionCenter: Position.fromMap(data?['actionCenter']),
      damage: Damage.fromMap(data?['damage']),
      range: Range.fromMap(data?['range']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'angle': angle,
      'distance': distance,
      'actionCenter': actionCenter.toMap(),
      'damage': damage.toMap(),
      'range': range.toMap(),
    };
  }
}

class Target {
  String id;
  String type;
  Position position;
  int damage;
  Target(
      {required this.id,
      required this.type,
      required this.position,
      required this.damage});

  factory Target.empty() {
    return Target(
      id: '',
      type: '',
      position: Position.empty(),
      damage: 0,
    );
  }

  factory Target.fromMap(Map<String, dynamic>? data) {
    return Target(
      id: data?['id'],
      type: data?['type'],
      position: Position.fromMap(data?['position']),
      damage: data?['damage'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'position': position.toMap(),
      'damage': damage,
    };
  }
}
