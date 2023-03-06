import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/position.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;

class Combat {
  ActionArea actionArea = ActionArea();
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
    actionArea.reset();
  }

  void confirmAttack(
    List<Npc> npcs,
    List<Player> players,
  ) {
    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        npc.receiveAttack(attack);
      }
    }

    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        player.receiveAttack(attack);
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

    actionArea.setArea(angle, distance, actionCenter, attack.range);
  }
}

// class BattleLog {}
