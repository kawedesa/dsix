import 'area_effect.dart';
import 'damage.dart';

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
