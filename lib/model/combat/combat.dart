import 'package:dsix/model/combat/area_effect.dart';
import 'package:dsix/model/combat/position.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';

class Combat {
  AreaEffect areaEffect = AreaEffect();
  // BattleLog battleLog = BattleLog();

  void setAttack(
      double angle, double distance, Position position, Attack attack) {
    areaEffect.setArea(angle, distance, position, attack);
  }

  void resetAttack() {
    areaEffect.reset();
  }

  void confirmPlayerAttack(List<Npc> npcs, List<Player> players,
      Player selectedPlayer, Attack attack) {
    int rawDamage = selectedPlayer.attributes.power.getRawDamage();

    for (Npc npc in npcs) {
      if (areaEffect.insideArea(npc.position)) {
        npc.receiveAttack(attack.damage, rawDamage);
        // battleLog.addAttackLog(selectedPlayer.name, attack.name, npc.race);
      }
    }

    for (Player player in players) {
      if (areaEffect.insideArea(player.position)) {
        player.receiveAttack(attack.damage, rawDamage);
        //  battleLog.addAttackLog(selectedPlayer.name, attack.name, player.name);
      }
    }
  }

  void confirmNpcAttack(
      List<Npc> npcs, List<Player> players, Npc selectedNpc, Attack attack) {
    int rawDamage = selectedNpc.power.getRawDamage();

    for (Npc npc in npcs) {
      if (areaEffect.insideArea(npc.position)) {
        npc.receiveAttack(attack.damage, rawDamage);
        //  battleLog.addAttackLog(selectedNpc.race, attack.name, npc.race);
      }
    }

    for (Player player in players) {
      if (areaEffect.insideArea(player.position)) {
        player.receiveAttack(attack.damage, rawDamage);
        // battleLog.addAttackLog(selectedNpc.race, attack.name, player.name);
      }
    }
  }
}

// class BattleLog {}
