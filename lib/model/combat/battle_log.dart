import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';

class BattleLog {
  String id;
  String message;
  Npc? selectedNpc;
  Player? selectedPlayer;
  Attack attack;
  AttackInfo attackInfo;
  List<Target> targets;

  BattleLog({
    required this.id,
    required this.message,
    this.selectedNpc,
    this.selectedPlayer,
    required this.attack,
    required this.attackInfo,
    required this.targets,
  });

  final database = FirebaseFirestore.instance;

  factory BattleLog.empty() {
    return BattleLog(
      id: '',
      message: '',
      selectedNpc: null,
      selectedPlayer: null,
      attack: Attack.empty(),
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
      id: '',
      message: '',
      selectedNpc: null,
      selectedPlayer: null,
      attack: Attack.fromMap(data?['attack']),
      attackInfo: AttackInfo.fromMap(data?['attackInfo']),
      targets: getTargets,
    );
  }

  Map<String, dynamic> toMap() {
    var targetToMap = targets.map((target) => target.toMap()).toList();

    return {
      'id': id,
      'message': message,
      'selectedNpc': (selectedNpc == null) ? null : selectedNpc!.toMap(),
      'selectedPlayer':
          (selectedPlayer == null) ? null : selectedPlayer!.toMap(),
      'attack': attack.toMap(),
      'attackInfo': attackInfo.toMap(),
      'targets': targetToMap,
    };
  }

  void createNewBattleLog() {}
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

class AttackInfo {
  String id;
  String type;
  Position position;
  int damage;
  AttackInfo(
      {required this.id,
      required this.type,
      required this.position,
      required this.damage});

  factory AttackInfo.empty() {
    return AttackInfo(
      id: '',
      type: '',
      position: Position.empty(),
      damage: 0,
    );
  }

  factory AttackInfo.fromMap(Map<String, dynamic>? data) {
    return AttackInfo(
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
