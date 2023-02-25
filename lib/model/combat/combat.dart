import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/combat/range.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'damage.dart';

class Combat {
  Attack attack = Attack.empty();

  void setAttack(double angle, double distance, Position position, Range range,
      Damage damage) {
    attack.aoe.setArea(angle, distance, position, range);
    attack.damage = damage;
  }

  void resetAttack() {
    attack.aoe.reset();
  }

  void confirmAttack(List<Npc> npcs, List<Player> players) {
    for (Npc npc in npcs) {
      if (attack.aoe.insideArea(npc.position)) {
        npc.receiveAttack(attack.damage);
      }
    }

    for (Player player in players) {
      if (attack.aoe.insideArea(player.position)) {
        player.receiveAttack(attack.damage);
      }
    }
  }
}
