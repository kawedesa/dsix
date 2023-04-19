import 'package:dsix/model/combat/battle_log.dart';
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
    if (currentTurn == 'player') {
      for (Player player in players) {
        int checkLife = player.life.current;
        player.passTurn();

        int damage = checkLife - player.life.current;

        if (damage < 1) {
          continue;
        }
        battleLog.addTarget(player.id, player.position, damage, 0);
      }
    } else {
      for (Npc npc in npcs) {
        int checkLife = npc.life.current;

        npc.passTurn();

        int damage = checkLife - npc.life.current;

        if (damage < 1) {
          continue;
        }
        battleLog.addTarget(npc.id.toString(), npc.position, damage, 0);
      }
    }

    count++;
    if (currentTurn == 'player') {
      currentTurn = 'npc';
    } else {
      currentTurn = 'player';
    }

    battleLog.newBattleLog();
  }
}
