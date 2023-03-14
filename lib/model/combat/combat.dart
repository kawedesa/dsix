import 'package:dsix/model/combat/action_area.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:flutter/material.dart';
import '../npc/npc.dart';
import '../player/player.dart';
import 'attack.dart';
import 'dart:math' as math;
import 'battle_log.dart';

class Combat {
  ActionArea actionArea = ActionArea();
  Attack attack = Attack.empty();
  bool isAttacking = false;
  Position inputCenter = Position.empty();
  Position actionCenter = Position.empty();
  Offset mousePosition = Offset.zero;
  BattleLog battleLog = BattleLog.empty();

  void startAttack(Position inputCenter, Position actionCenter, Attack attack) {
    this.inputCenter = inputCenter;
    this.actionCenter = actionCenter;
    this.attack = attack;
    isAttacking = true;
  }

  void setMousePosition(Offset position) {
    mousePosition = position;
  }

  void cancelAction() {
    attack = Attack.empty();
    isAttacking = false;
    inputCenter = Position.empty();
    actionCenter = Position.empty();
    mousePosition = Offset.zero;
    resetActionArea();
  }

  void resetActionArea() {
    actionArea.reset();
  }

  void setActionArea() {
    double angle = math.atan2(mousePosition.dy - inputCenter.dy,
            mousePosition.dx - inputCenter.dx) -
        1.5708;

    double distance = (inputCenter.getDistanceFromPoint(mousePosition)) / 500;

    if (distance > 1) {
      distance = 1;
    }

    actionArea.setArea(angle, distance, actionCenter, attack.range);
  }

  void confirmPlayerAttack(
      List<Npc> npcs, List<Player> players, Player selectedPlayer) {
//TODO CREATE BATTLELOG

    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        npc.receiveAttack(attack);
        selectedPlayer
            .receiveEffect(npc.effects.passiveEffects.onBeingHitEffect);

        if (npc.life.isDead()) {
          npc.createLoot();
        }
      }
    }

    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        player.receiveAttack(attack);

        selectedPlayer
            .receiveEffect(player.effects.passiveEffects.onBeingHitEffect);
      }
    }
  }

  void confirmNpcAttack(
      List<Npc> npcs, List<Player> players, Npc? selectedNpc) {
    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        npc.receiveAttack(attack);

        selectedNpc!.receiveEffect(npc.effects.passiveEffects.onBeingHitEffect);
        if (npc.life.isDead()) {
          npc.createLoot();
        }
      }
    }

    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        player.receiveAttack(attack);

        selectedNpc!
            .receiveEffect(player.effects.passiveEffects.onBeingHitEffect);
      }
    }
  }
}
