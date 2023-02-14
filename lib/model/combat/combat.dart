import 'package:dsix/model/combat/damage.dart';
import 'package:dsix/model/combat/position.dart';

import '../item/item.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'area_effect.dart';

class Combat {
  Attack attack = Attack.empty();

  void setAttack(double angle, double distance, Position position, Item item) {
    double distanceScale = distance * 50;
    attack.aoe.setArea(angle, distanceScale, position, item.attackType);
    attack.damage.pDamage = item.pDamage;
    attack.damage.mDamage = item.mDamage;
  }

  void resetAttack() {
    attack.aoe.reset();
  }

  void confirmAttack(List<Npc> npcs, List<Player> players, Player player) {
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

class Attack {
  Damage damage;
  AreaEffect aoe;

  Attack({required this.damage, required this.aoe});

  factory Attack.empty() {
    return Attack(
      damage: Damage.empty(),
      aoe: AreaEffect(),
    );
  }

  void reset() {
    damage = Damage.empty();
    aoe.reset();
  }
}
