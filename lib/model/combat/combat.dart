import 'package:dsix/model/combat/area_effect.dart';
import 'package:dsix/model/combat/position.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;

class Combat {
  AreaEffect areaEffect = AreaEffect();
  Attack attack = Attack.empty();
  Position inputCenter = Position.empty();
  Position actionCenter = Position.empty();
  Position mousePosition = Position.empty();
  // BattleLog battleLog = BattleLog();

  void setInputCenterPosition(Position position) {
    inputCenter = position;
  }

  void setActionCenterPosition(Position position) {
    actionCenter = position;
  }

  void setMousePosition(Position position) {
    mousePosition = position;
  }

  void setAttack(Attack attack) {
    this.attack = attack;
  }

  void cancelAction() {
    attack = Attack.empty();
    inputCenter = Position.empty();
    actionCenter = Position.empty();
    mousePosition = Position.empty();
    resetActionArea();
  }

  void resetActionArea() {
    areaEffect.reset();
  }

  void setActionArea() {
    double angle = math.atan2(mousePosition.dy - inputCenter.dy,
            mousePosition.dx - inputCenter.dx) -
        1.5708;

    double distance =
        (inputCenter.getDistanceFromPosition(mousePosition)) / 200;

    if (distance > 1) {
      distance = 1;
    }

    areaEffect.setArea(angle, distance, actionCenter, attack.range);
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
