import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/ui/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerActioButtons extends StatefulWidget {
  final Function() refresh;

  const PlayerActioButtons({super.key, required this.refresh});

  @override
  State<PlayerActioButtons> createState() => _PlayerActioButtonsState();
}

class _PlayerActioButtonsState extends State<PlayerActioButtons> {
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
        icon: AppImages.defense,
        color: user.color.withAlpha(175),
        darkColor: user.darkColor.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.player.defend();
          widget.refresh();
        },
        resetAction: () {},
        resetArea: () {});
  }

  Widget createLookActionButton(User user) {
    int id = 2;
    return ActionButton(
        id: id,
        icon: AppImages.vision,
        color: user.color.withAlpha(175),
        darkColor: user.darkColor.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.player.look();
          widget.refresh();
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
        user.combat.startAttack(
            user.mapInfo.getOnScreenPosition(user.player.position),
            user.player.position,
            user.player.attack(attack),
            user.player,
            null);

        user.playerActionMode();
        widget.refresh();
      },
      resetAction: () {
        deselectActionButton();
        user.combat.resetAction();
        user.playerStandMode();
        widget.refresh();
      },
      resetArea: () {
        user.combat.resetArea();
        widget.refresh();
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

        refresh();
      },
      onTap: () {
        deselectActionButton();
        user.combat.confirmAttack(npcs, players);
        user.combat.resetAction();
        user.playerStandMode();
        refresh();
      },
    );

    return attackInputWidget;
  }

  void refresh() {
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
