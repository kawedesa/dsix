import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsix/model/combat/action_info.dart';

import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';

class BattleLog {
  int id;
  String message;

  ActionInfo attackInfo;
  List<Target> targets;
  List<AuraInfo> auras;

  BattleLog({
    required this.id,
    required this.message,
    required this.attackInfo,
    required this.targets,
    required this.auras,
  });

  final database = FirebaseFirestore.instance;
  List<Target> possibleTargets = [];

  factory BattleLog.empty() {
    return BattleLog(
      id: 0,
      message: '',
      attackInfo: ActionInfo.empty(),
      targets: [],
      auras: [],
    );
  }

  factory BattleLog.fromMap(Map<String, dynamic>? data) {
    List<Target> getTargets = [];
    List<dynamic> targetsMap = data?['targets'];
    for (var target in targetsMap) {
      getTargets.add(Target.fromMap(target));
    }

    List<AuraInfo> getAuras = [];
    List<dynamic> aurasMap = data?['auras'];
    for (var aura in aurasMap) {
      getAuras.add(AuraInfo.fromMap(aura));
    }

    return BattleLog(
      id: data?['id'],
      message: data?['message'],
      attackInfo: ActionInfo.fromMap(data?['attackInfo']),
      targets: getTargets,
      auras: getAuras,
    );
  }

  Map<String, dynamic> toMap() {
    var targetToMap = targets.map((target) => target.toMap()).toList();
    var aurasToMap = auras.map((aura) => aura.toMap()).toList();

    return {
      'id': id,
      'message': message,
      'attackInfo': attackInfo.toMap(),
      'targets': targetToMap,
      'auras': aurasToMap,
    };
  }

  void setPossibleTargets(List<Npc> npcs, List<Player> players) {
    possibleTargets = [];

    for (Player player in players) {
      if (player.life.isDead()) {
        continue;
      }
      possibleTargets.add(Target(
          id: player.id,
          position: player.position,
          gold: player.equipment.gold,
          life: player.life.current,
          armor: player.attributes.defense.tempArmor));
    }

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        continue;
      }
      possibleTargets.add(Target(
          id: npc.id.toString(),
          position: npc.position,
          gold: 0,
          life: npc.life.current,
          armor: npc.attributes.defense.tempArmor));
    }
  }

  void addTargets(List<Npc> npcs, List<Player> players) {
    for (Npc npc in npcs) {
      for (Target target in possibleTargets) {
        if (target.id != npc.id.toString()) {
          continue;
        }
        if (target.life == npc.life.current &&
            target.armor == npc.attributes.defense.tempArmor) {
          //WASN'T DAMAGED
          continue;
        }
        target.life -= npc.life.current;
        target.armor -= npc.attributes.defense.tempArmor;
        targets.add(target);
      }
    }

    for (Player player in players) {
      for (Target target in possibleTargets) {
        if (target.id != player.id) {
          continue;
        }

        if (target.life == player.life.current &&
            target.armor == player.attributes.defense.tempArmor &&
            target.gold == player.equipment.gold) {
          //WASN'T DAMAGED OR STOLEN
          continue;
        }

        target.life -= player.life.current;
        target.armor -= player.attributes.defense.tempArmor;
        target.gold -= player.equipment.gold;
        targets.add(target);
      }
    }
  }

  void setAttackInfo(ActionInfo info) {
    attackInfo = info;
  }

  void addAuras(String aura, Position position) {
    auras.add(AuraInfo(position: position, aura: aura));
  }

  void newBattleLog() {
    if (auras.isEmpty &&
        targets.isEmpty &&
        attackInfo.ability.name == '' &&
        attackInfo.attack.name == '') {
      return;
    }

    id = DateTime.now().millisecondsSinceEpoch;
    set();
    reset();
  }

  void reset() {
    id = 0;
    message = '';
    attackInfo = ActionInfo.empty();
    targets = [];
    auras = [];
    possibleTargets = [];
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
  int gold;
  int life;
  int armor;
  Target({
    required this.id,
    required this.position,
    required this.gold,
    required this.life,
    required this.armor,
  });

  factory Target.empty() {
    return Target(
      id: '',
      position: Position.empty(),
      gold: 0,
      life: 0,
      armor: 0,
    );
  }

  factory Target.fromMap(Map<String, dynamic>? data) {
    return Target(
      id: data?['id'],
      position: Position.fromMap(data?['position']),
      gold: data?['gold'],
      life: data?['life'],
      armor: data?['armor'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'position': position.toMap(),
      'gold': gold,
      'life': life,
      'armor': armor,
    };
  }
}

class AuraInfo {
  Position position;
  String aura;

  AuraInfo({
    required this.position,
    required this.aura,
  });

  factory AuraInfo.empty() {
    return AuraInfo(
      position: Position.empty(),
      aura: '',
    );
  }

  factory AuraInfo.fromMap(Map<String, dynamic>? data) {
    return AuraInfo(
      position: Position.fromMap(data?['position']),
      aura: data?['aura'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'position': position.toMap(),
      'aura': aura,
    };
  }
}
