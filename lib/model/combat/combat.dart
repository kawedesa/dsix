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
    battleLog.reset();
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
    battleLog.reset();
  }

  void resetActionArea() {
    actionArea.reset();
  }

  void setActionArea() {
    double angle = math.atan2(mousePosition.dy - inputCenter.dy,
            mousePosition.dx - inputCenter.dx) -
        1.5708;

    double distance = (inputCenter.getDistanceFromPoint(mousePosition)) / 300;

    if (distance > 1) {
      distance = 1;
    }

    actionArea.setArea(angle, distance, actionCenter, attack.range);
    battleLog.setAttackInfo(attack.name, angle, distance, actionCenter,
        attack.damage, attack.range);
  }

  void confirmPlayerAttack(
      List<Npc> npcs, List<Player> players, Player selectedPlayer) {
    battleLog.setAttacker(null, selectedPlayer);

    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        int damageTaken = 0;

        npc.receiveAttack(attack, (damage) {
          damageTaken = damage;
        });
        battleLog.addTarget(
            npc.id.toString(), 'npc', npc.position, damageTaken);

//TODO COMEBACK TO FIX
        // selectedPlayer
        //     .receiveEffect(npc.effects.passiveEffects.onBeingHitEffect);

        if (npc.life.isDead()) {
          npc.createLoot();
        }
      }
    }

    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        int damageTaken = 0;

        player.receiveAttack(attack, (damage) {
          damageTaken = damage;
        });
        battleLog.addTarget(player.id, 'player', player.position, damageTaken);

        // selectedPlayer
        //     .receiveEffect(player.effects.passiveEffects.onBeingHitEffect);
      }
    }

    battleLog.newBattleLog();
  }

  void confirmNpcAttack(
      List<Npc> npcs, List<Player> players, Npc? selectedNpc) {
    battleLog.setAttacker(selectedNpc, null);

    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        int damageTaken = 0;

        npc.receiveAttack(attack, (damage) {
          damageTaken = damage;
        });
        battleLog.addTarget(
            npc.id.toString(), 'npc', npc.position, damageTaken);
        // selectedNpc!.receiveEffect(npc.effects.passiveEffects.onBeingHitEffect);

        if (npc.life.isDead()) {
          npc.createLoot();
        }
      }
    }

    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        int damageTaken = 0;

        player.receiveAttack(attack, (damage) {
          damageTaken = damage;
        });
        battleLog.addTarget(player.id, 'player', player.position, damageTaken);
        // selectedNpc!
        //     .receiveEffect(player.effects.passiveEffects.onBeingHitEffect);
      }
    }
    battleLog.newBattleLog();
  }
}
