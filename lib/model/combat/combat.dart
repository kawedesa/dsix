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
  bool isTakingAction = false;
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
    isTakingAction = true;
    battleLog.setAttacker(selectedNpc, selectedPlayer);
  }

  void setMousePosition(Offset position) {
    mousePosition = position;
  }

  void resetAction() {
    attack = Attack.empty();
    isTakingAction = false;
    inputCenter = Position.empty();
    actionCenter = Position.empty();
    mousePosition = Offset.zero;
    selectedNpc = null;
    selectedPlayer = null;
    resetArea();
    battleLog.reset();
  }

  void resetArea() {
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
    unloadAttack();
    attackNpcs(npcs);
    attackPlayers(players);
    applyAttackerEffects();
    battleLog.newBattleLog();
  }

  void applyAttackerEffects() {
    for (String effect in attack.effects) {
      switch (effect) {
        case 'drain':
          int healAmount = battleLog.targets.length;
          if (selectedNpc != null) {
            selectedNpc!.heal(healAmount);
            battleLog.addTarget(selectedNpc!.id.toString(), 'npc',
                selectedNpc!.position, -healAmount);
          }
          if (selectedPlayer != null) {
            selectedPlayer!.heal(healAmount);
            battleLog.addTarget(selectedPlayer!.id.toString(), 'player',
                selectedPlayer!.position, -healAmount);
          }
          break;

        case 'kickback':
          if (selectedNpc != null) {
            selectedNpc!.knockBack(actionCenter.withOffset(Offset(
                -math.sin(battleLog.attackInfo.angle),
                math.cos(battleLog.attackInfo.angle))));
          }
          if (selectedPlayer != null) {
            selectedNpc!.knockBack(actionCenter.withOffset(Offset(
                -math.sin(battleLog.attackInfo.angle),
                math.cos(battleLog.attackInfo.angle))));
          }

          break;
      }
    }
  }

  void unloadAttack() {
    if (selectedPlayer != null) {
      selectedPlayer!.unload(attack);
    }

    if (selectedNpc != null) {
      selectedNpc!.unload(attack);
    }
  }

  void attackNpcs(List<Npc> npcs) {
    for (Npc npc in npcs) {
      if (actionArea.insideArea(npc.position) && npc.life.isAlive()) {
        if (attack.type == 'melee') {
          applyOnBeignHitEffects(npc.effects.onBeignHitEffects);
        }

        int damage = 0;
        damage = npc.receiveAttack(attack);

        if (damage > 0) {
          npc.receiveEffects(attack.effects);
          if (attack.effects.contains('knockback')) {
            npc.knockBack(actionCenter);
          }

          battleLog.addTarget(npc.id.toString(), 'npc', npc.position, damage);
        }

        if (npc.life.isDead()) {
          npc.resetEffects();
          npc.createLoot();
        }
      }
    }
  }

  void attackPlayers(List<Player> players) {
    for (Player player in players) {
      if (actionArea.insideArea(player.position) && player.life.isAlive()) {
        if (attack.type == 'melee') {
          applyOnBeignHitEffects(player.effects.onBeignHitEffects);
        }

        int damage = 0;
        damage = player.receiveAttack(attack);

        if (damage > 0) {
          player.receiveEffects(attack.effects);
          if (attack.effects.contains('knockback')) {
            player.knockBack(actionCenter);
          }
          battleLog.addTarget(player.id, 'player', player.position, damage);
        }

        if (player.life.isDead()) {
          player.resetEffects();
        }
      }
    }
  }

  void applyOnBeignHitEffects(List<String> effects) {
    applyEffectsToSelectedPlayer(effects);
    applyEffectsToSelectedNpc(effects);
  }

  void applyEffectsToSelectedPlayer(List<String> effects) {
    if (selectedPlayer == null) {
      return;
    }

    int checkLife = selectedPlayer!.life.current;
    selectedPlayer!.receiveEffects(effects);
    int damage = checkLife - selectedPlayer!.life.current;

    if (damage != 0) {
      battleLog.addTarget(selectedPlayer!.id.toString(), 'player',
          selectedPlayer!.position, damage);
    }
  }

  void applyEffectsToSelectedNpc(List<String> effects) {
    if (selectedNpc == null) {
      return;
    }

    int checkLife = selectedNpc!.life.current;
    selectedNpc!.receiveEffects(effects);
    int damage = checkLife - selectedNpc!.life.current;
    if (damage != 0) {
      battleLog.addTarget(
          selectedNpc!.id.toString(), 'npc', selectedNpc!.position, damage);
    }
  }
}
