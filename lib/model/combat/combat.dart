import 'package:dsix/model/combat/area_effect.dart';
import 'package:dsix/model/combat/position.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;

class Combat {
  AreaEffect areaEffect = AreaEffect();
  Attack attack = Attack.empty();
  bool isAttacking = false;
  Position inputCenter = Position.empty();
  Position actionCenter = Position.empty();
  Position mousePosition = Position.empty();
  // BattleLog battleLog = BattleLog();

  void startAttack(Position inputCenter, Position actionCenter, Attack attack) {
    this.inputCenter = inputCenter;
    this.actionCenter = actionCenter;
    this.attack = attack;
    isAttacking = true;
  }

  void setMousePosition(Position position) {
    mousePosition = position;
  }

  void cancelAction() {
    attack = Attack.empty();
    isAttacking = false;
    inputCenter = Position.empty();
    actionCenter = Position.empty();
    mousePosition = Position.empty();
    resetActionArea();
  }

  void resetActionArea() {
    areaEffect.reset();
  }

  void confirmAttack(
    List<Npc> npcs,
    List<Player> players,
  ) {
    for (Npc npc in npcs) {
      if (areaEffect.insideArea(npc.position)) {
        npc.receiveAttack(attack.damage);
      }
    }

    for (Player player in players) {
      if (areaEffect.insideArea(player.position)) {
        player.receiveAttack(attack.damage);
      }
    }
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
}

// class BattleLog {}
