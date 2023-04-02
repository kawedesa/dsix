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
  Player? selectedPlayer;
  Npc? selectedNpc;

  void startAttack(Position inputCenter, Position actionCenter, Attack attack,
      Player? selectedPlayer, Npc? selectedNpc) {
    battleLog.reset();
    this.selectedPlayer = selectedPlayer;
    this.selectedNpc = selectedNpc;
    this.inputCenter = inputCenter;
    this.actionCenter = actionCenter;
    this.attack = attack;
    isAttacking = true;
    battleLog.setAttacker(selectedNpc, selectedPlayer);
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
    selectedNpc = null;
    selectedPlayer = null;
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

    battleLog.setAttackInfo(attack.name, angle, distance, actionCenter,
        attack.damage, attack.range);

    actionArea.setArea(battleLog.attackInfo);
  }

  void confirmAttack(List<Npc> npcs, List<Player> players) {
    attackNpcs(npcs);
    attackPlayers(players);
    battleLog.newBattleLog();
  }

  void attackNpcs(List<Npc> npcs) {
    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position)) {
        int damage = 0;

        applyOnBeignHitEffects(npc.effects.onBeignHitEffects);
        damage = npc.receiveAttack(attack);

        battleLog.addTarget(npc.id.toString(), 'npc', npc.position, damage);

        if (npc.life.isDead()) {
          npc.createLoot();
        }
      }
    }
  }

  void attackPlayers(List<Player> players) {
    for (Player player in players) {
      if (actionArea.insideArea(player.position)) {
        int damage = 0;

        applyOnBeignHitEffects(player.effects.onBeignHitEffects);
        damage = player.receiveAttack(attack);

        battleLog.addTarget(player.id, 'player', player.position, damage);
      }
    }
  }

  void applyOnBeignHitEffects(List<String> effects) {
    if (selectedNpc != null) {
      selectedNpc!.receiveEffects(effects);
    }

    if (selectedPlayer != null) {
      selectedPlayer!.receiveEffects(effects);
    }
  }
}
