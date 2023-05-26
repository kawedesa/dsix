import 'dart:math';
import 'package:dsix/model/combat/ability.dart';
import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/model/map/mouse_input.dart';
import 'package:dsix/model/map/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NpcActionButtons extends StatefulWidget {
  final Function() fullRefresh;
  const NpcActionButtons({super.key, required this.fullRefresh});

  @override
  State<NpcActionButtons> createState() => _NpcActionButtonsState();
}

class _NpcActionButtonsState extends State<NpcActionButtons> {
  final BattleLog _battleLog = BattleLog.empty();

  int selectedButtonId = 0;
  void selectActionButton(int id) {
    selectedButtonId = id;
  }

  void deselectActionButton() {
    selectedButtonId = 0;
  }

  bool checkSelectedButton(int id) {
    if (id == selectedButtonId) {
      return true;
    } else {
      return false;
    }
  }

  bool hideButton(User user, int id) {
    if (user.npc == null) {
      return true;
    }
    if (user.npcMode == 'wait') {
      return true;
    }

    if (id != selectedButtonId && selectedButtonId != 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget createActionButtons(User user) {
    if (user.npc == null) {
      return const SizedBox();
    }

    List<Widget> displayButtons = [];
    List<Widget> npcActionButtons = createNpcActionButtons(user);

    displayButtons.add(const AppSeparatorHorizontal(value: 0.05));
    displayButtons.add(createDefendButton(user));
    displayButtons.add(const AppSeparatorHorizontal(value: 0.05));
    displayButtons.add(createLookButton(user));
    displayButtons.add(const AppSeparatorHorizontal(value: 0.05));
    for (Widget button in npcActionButtons) {
      displayButtons.add(button);
      displayButtons.add(const AppSeparatorHorizontal(value: 0.05));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: displayButtons,
    );
  }

  Widget createDefendButton(User user) {
    int id = 1;
    return ActionButton(
        id: id,
        icon: AppImages.actionDefend,
        color: AppColors.uiColor.withAlpha(175),
        darkColor: AppColors.uiColorDark.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.npc!.defend();
          user.npc!.update();
          _battleLog.reset();
          _battleLog.addAuras('defend', user.npc!.position);
          _battleLog.newBattleLog();
        },
        resetAction: () {},
        resetArea: () {});
  }

  Widget createLookButton(User user) {
    int id = 2;
    return ActionButton(
        id: id,
        icon: AppImages.actionLook,
        color: AppColors.uiColor.withAlpha(175),
        darkColor: AppColors.uiColorDark.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.npc!.look();
          user.npc!.update();
          _battleLog.reset();
          _battleLog.addAuras('look', user.npc!.position);
          _battleLog.newBattleLog();
        },
        resetAction: () {},
        resetArea: () {});
  }

  List<Widget> createNpcActionButtons(User user) {
    List<Widget> npcActionButtons = [];

    for (int i = 0; i < user.npc!.attacks.length; i++) {
      Attack attack = user.npc!.attacks[i];
      int id = 3 + i;

      if (attack.needsReload) {
        if (attack.isLoaded) {
          npcActionButtons.add(createAttackButton(id, user, attack));
        } else {
          npcActionButtons.add(createReloadButton(id, user, attack));
        }
      } else {
        npcActionButtons.add(createAttackButton(id, user, attack));
      }
    }

    for (int i = 0; i < user.npc!.abilities.length; i++) {
      int id = 3 + i + user.npc!.attacks.length;
      Ability ability = user.npc!.abilities[i];

      if (ability.cooldown > 0 && ability.cooldownCount > 0) {
        npcActionButtons
            .add(createCooldownButton(id, user, ability.cooldownCount));
        continue;
      }

      npcActionButtons
          .add(createAbilityButton(id, user, user.npc!.abilities[i]));
    }

    return npcActionButtons;
  }

  Widget createAttackButton(int id, User user, Attack attack) {
    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon(attack.name),
      color: AppColors.uiColor.withAlpha(175),
      darkColor: AppColors.uiColorDark.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {
        selectActionButton(id);
        user.combat.startAttack(
            user.mapInfo.getOnScreenPosition(user.npc!.position),
            user.npc!.position,
            user.npc!.attack(attack),
            null,
            user.npc!);

        user.npcActionMode();
        localRefresh();
      },
      resetAction: () {
        deselectActionButton();
        user.combat.resetAction();
        user.npcStandMode();
        widget.fullRefresh();
      },
      resetArea: () {
        user.combat.resetArea();
        localRefresh();
      },
    );
  }

  Widget createReloadButton(int id, User user, Attack attack) {
    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon('reload'),
      color: AppColors.uiColor.withAlpha(175),
      darkColor: AppColors.uiColorDark.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {
        user.npc!.reload(attack);
        user.npc!.update();
        _battleLog.reset();
        _battleLog.addAuras('reload', user.npc!.position);
        _battleLog.newBattleLog();
        localRefresh();
      },
      resetAction: () {},
      resetArea: () {},
    );
  }

  Widget createCooldownButton(int id, User user, int cooldownCount) {
    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon('empty'),
      cooldown: cooldownCount,
      color: AppColors.uiColor.withAlpha(175),
      darkColor: AppColors.uiColorDark.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {},
      resetAction: () {},
      resetArea: () {},
    );
  }

  Widget createAbilityButton(int id, User user, Ability ability) {
    Function startAction = () {
      selectActionButton(id);
      user.combat.startAbility(
          user.mapInfo.getOnScreenPosition(user.npc!.position),
          user.npc!.position,
          ability,
          null,
          user.npc);

      user.npcActionMode();
      localRefresh();
    };

    switch (ability.name) {
      case 'mirror images':
        startAction = () {
          user.npc!.setCooldown('mirror images');
          user.npc!.update();

          Npc mirrorImage = user.npc!;

          mirrorImage.abilities = [];
          mirrorImage.attacks = [];
          mirrorImage.receiveEffects(['illusion', 'illusion']);

          for (int i = 0; i < 3; i++) {
            mirrorImage.id = DateTime.now().millisecondsSinceEpoch + i;
            mirrorImage.position.dx += Random().nextInt(20) - 10;
            mirrorImage.position.dy += Random().nextInt(20) - 10;
            mirrorImage.set();
          }
          localRefresh();
        };
        break;
      case 'hide':
        startAction = () {
          user.npc!.setCooldown('hide');
          user.npc!.receiveEffects(['invisible', 'invisible']);
          user.npc!.update();
          localRefresh();
        };
        break;
    }

    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon(ability.name),
      color: AppColors.uiColor.withAlpha(175),
      darkColor: AppColors.uiColorDark.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {
        startAction();
      },
      resetAction: () {
        deselectActionButton();
        user.combat.resetAction();
        user.npcStandMode();
        widget.fullRefresh();
      },
      resetArea: () {
        user.combat.resetArea();
        localRefresh();
      },
    );
  }

  Widget getActionInput(User user, List<Npc> npcs, List<Player> players) {
    Widget attackInputWidget = MouseInput(
      active: (user.npcMode == 'action') ? true : false,
      getMouseOffset: (mouseOffset) {
        user.combat.setMousePosition(mouseOffset);
        user.combat.setActionArea();
        widget.fullRefresh();
      },
      onTap: () {
        deselectActionButton();
        user.combat.confirmAction(npcs, players);
        user.combat.resetAction();
        user.npcStandMode();
        localRefresh();
      },
    );

    return attackInputWidget;
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final npcs = Provider.of<List<Npc>>(context);
    final players = Provider.of<List<Player>>(context);

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: (user.placingSomething == 'false')
          ? Stack(
              children: [
                getActionInput(user, npcs, players),
                Align(
                    alignment: const Alignment(0, 0.50),
                    child: createActionButtons(user)),
              ],
            )
          : const SizedBox(),
    );
  }
}
