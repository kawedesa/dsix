import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';

class Turn {
  int count;
  String currentTurn;
  Turn({
    required this.count,
    required this.currentTurn,
  });

  BattleLog battleLog = BattleLog.empty();

  factory Turn.empty() {
    return Turn(
      count: 1,
      currentTurn: 'player',
    );
  }

  factory Turn.fromMap(Map<String, dynamic>? data) {
    return Turn(
      count: data?['count'],
      currentTurn: data?['currentTurn'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'currentTurn': currentTurn,
    };
  }

  void reset() {
    count = 1;
    currentTurn = 'player';
    battleLog.reset();
  }

  void passTurn(List<Player> players, List<Npc> npcs) {
    List<Npc> markNpcsToDelete = [];
    battleLog.setPossibleTargets(npcs, players);

    switch (currentTurn) {
      case 'player':
        for (Player player in players) {
          if (player.life.isDead()) {
            continue;
          }
          player.passTurn();
          player.update();
        }
        for (Npc npc in npcs) {
          if (npc.effects.onDeath.contains('delete')) {
            markNpcsToDelete.add(npc);
            continue;
          }

          if (npc.life.isDead()) {
            continue;
          }

          npc.resetTemporaryAttributes();
          npc.update();
        }
        break;
      case 'npc':
        for (Npc npc in npcs) {
          if (npc.effects.onDeath.contains('delete')) {
            markNpcsToDelete.add(npc);
            continue;
          }
          if (npc.life.isDead()) {
            continue;
          }
          npc.passTurn(players, npcs);
          npc.update();
        }
        for (Player player in players) {
          if (player.life.isDead()) {
            continue;
          }
          player.resetTemporaryAttributes();
          player.update();
        }
        break;
    }

    for (Npc npc in markNpcsToDelete) {
      npc.delete();
    }

    count++;
    if (currentTurn == 'player') {
      currentTurn = 'npc';
      checkNpcAuras(players, npcs);
    } else {
      currentTurn = 'player';
      checkPlayerAuras(players, npcs);
    }

    battleLog.addTargets(npcs, players);
    battleLog.newBattleLog();
  }

  void checkNpcAuras(List<Player> players, List<Npc> npcs) {
    for (Npc npc in npcs) {
      if (npc.effects.auras.isEmpty || npc.life.isDead()) {
        continue;
      }
      for (String aura in npc.effects.auras) {
        applyAura(aura, 'npc', npc.position, players, npcs);
        battleLog.addAuras(aura, npc.position);
      }
    }
  }

  void checkPlayerAuras(List<Player> players, List<Npc> npcs) {
    for (Player player in players) {
      if (player.effects.auras.isEmpty || player.life.isDead()) {
        continue;
      }
      for (String aura in player.effects.auras) {
        applyAura(aura, 'player', player.position, players, npcs);
        battleLog.addAuras(aura, player.position);
      }
    }
  }

  void applyAura(String aura, String caster, Position position,
      List<Player> players, List<Npc> npcs) {
    int auraRadius = 25;

    switch (aura) {
      case 'empower':
        if (caster == 'npc') {
          for (Npc npc in npcs) {
            if (npc.position.getDistanceFromPosition(position) > auraRadius ||
                npc.life.isDead()) {
              continue;
            }
            npc.receiveEffects(['empower']);
            npc.update();
          }
        }
        break;

      case 'cry':
        for (Npc npc in npcs) {
          if (npc.name != 'mama bear') {
            continue;
          }
          if (npc.position.getDistanceFromPosition(position) > auraRadius ||
              npc.life.isDead()) {
            continue;
          }
          npc.receiveEffects(['empower', 'empower']);
          npc.update();
        }
        break;
    }
  }
}
