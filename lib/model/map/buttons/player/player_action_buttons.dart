import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/battle_log.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/model/map/mouse_input.dart';
import 'package:dsix/model/map/buttons/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerActioButtons extends StatefulWidget {
  final Function(Path) getActionArea;
  final Function() fullRefresh;

  const PlayerActioButtons(
      {super.key, required this.getActionArea, required this.fullRefresh});

  @override
  State<PlayerActioButtons> createState() => _PlayerActioButtonsState();
}

class _PlayerActioButtonsState extends State<PlayerActioButtons> {
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
    if (user.playerMode == 'wait') {
      return true;
    }

    if (user.player.life.isDead()) {
      return true;
    }

    if (id != selectedButtonId && selectedButtonId != 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget createActionButtons(User user) {
    List<Widget> actionButtons = [];
    List<Widget> itemActionButtons = createItemActionButtons(user);

    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    actionButtons.add(createDefendActionButton(user));
    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    actionButtons.add(createLookActionButton(user));
    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    for (Widget button in itemActionButtons) {
      actionButtons.add(button);
      actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actionButtons,
    );
  }

  Widget createDefendActionButton(User user) {
    int id = 1;
    return ActionButton(
        id: id,
        icon: AppImages.actionDefend,
        color: user.color.withAlpha(175),
        darkColor: user.darkColor.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.player.defend();
          user.player.update();
          _battleLog.reset();
          _battleLog.addAuras('defend', user.player.position);
          _battleLog.newBattleLog();
        },
        resetAction: () {},
        resetArea: () {});
  }

  Widget createLookActionButton(User user) {
    int id = 2;
    return ActionButton(
        id: id,
        icon: AppImages.actionLook,
        color: user.color.withAlpha(175),
        darkColor: user.darkColor.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.player.look();
          user.player.update();
          _battleLog.reset();
          _battleLog.addAuras('look', user.player.position);
          _battleLog.newBattleLog();
        },
        resetAction: () {},
        resetArea: () {});
  }

  List<Widget> createItemActionButtons(User user) {
    List<Widget> itemAttackButtons = [];

    for (int i = 0;
        i < user.player.equipment.mainHandSlot.item.attacks.length;
        i++) {
      Attack attack = user.player.equipment.mainHandSlot.item.attacks[i];
      int id = 3 + i;

      if (attack.needsReload) {
        if (attack.isLoaded) {
          itemAttackButtons.add(createAttackButton(id, user, attack));
        } else {
          itemAttackButtons.add(createReloadButton(id, user, attack));
        }
      } else {
        itemAttackButtons.add(createAttackButton(id, user, attack));
      }
    }

    if (user.player.equipment.mainHandSlot.item.itemSlot == 'two hands') {
      return itemAttackButtons;
    }

    for (int i = 0;
        i < user.player.equipment.offHandSlot.item.attacks.length;
        i++) {
      Attack attack = user.player.equipment.offHandSlot.item.attacks[i];
      int id = 3 + i + user.player.equipment.mainHandSlot.item.attacks.length;

      if (attack.needsReload) {
        if (attack.isLoaded) {
          itemAttackButtons.add(createAttackButton(id, user, attack));
        } else {
          itemAttackButtons.add(createReloadButton(id, user, attack));
        }
      } else {
        itemAttackButtons.add(createAttackButton(id, user, attack));
      }
    }

    return itemAttackButtons;
  }

  Widget createAttackButton(int id, User user, Attack attack) {
    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon(attack.name),
      color: user.color.withAlpha(175),
      darkColor: user.darkColor.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {
        selectActionButton(id);
        user.playerActionMode();
        user.combat.startAttack(
            user.mapInfo.getOnScreenPosition(user.player.position),
            user.player.position,
            user.player.attack(attack),
            user.player,
            null);
        localRefresh();
      },
      resetAction: () {
        deselectActionButton();
        user.playerStandMode();
        user.combat.resetAction();
        widget.getActionArea(user.combat.actionArea.area);
        widget.fullRefresh();
      },
      resetArea: () {
        user.combat.resetArea();
        widget.getActionArea(user.combat.actionArea.area);
        localRefresh();
      },
    );
  }

  Widget createReloadButton(int id, User user, Attack attack) {
    return ActionButton(
      id: id,
      icon: AppImages().getActionIcon('reload'),
      color: user.color.withAlpha(175),
      darkColor: user.darkColor.withAlpha(225),
      selected: checkSelectedButton(id),
      hide: hideButton(user, id),
      startAction: () {
        user.player.reload(attack);
        user.player.update();
        _battleLog.reset();
        _battleLog.addAuras('reload', user.player.position);
        _battleLog.newBattleLog();
        localRefresh();
      },
      resetAction: () {},
      resetArea: () {},
    );
  }

  Widget getAttackInput(User user, List<Npc> npcs, List<Player> players) {
    Widget attackInputWidget = MouseInput(
      active: (user.playerMode == 'action') ? true : false,
      getMouseOffset: (mouseOffset) {
        user.combat.setMousePosition(mouseOffset);
        user.combat.setActionArea();
        widget.getActionArea(user.combat.actionArea.area);
      },
      onTap: () {
        deselectActionButton();
        user.playerStandMode();
        user.combat.confirmAction(npcs, players);
        user.combat.resetAction();
        widget.getActionArea(user.combat.actionArea.area);
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
      child: Stack(
        children: [
          getAttackInput(user, npcs, players),
          Align(
              alignment: const Alignment(0, 0.50),
              child: createActionButtons(user)),
        ],
      ),
    );
  }
}
