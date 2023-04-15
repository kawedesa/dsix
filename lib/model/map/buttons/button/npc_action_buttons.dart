import 'package:dsix/model/combat/attack.dart';
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

    List<Widget> actionButtons = [];
    List<Widget> npcAttackButtons = createNpcAttackButtons(user);

    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    actionButtons.add(createDefendActionButton(user));
    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    actionButtons.add(createLookActionButton(user));
    actionButtons.add(const AppSeparatorHorizontal(value: 0.05));
    for (Widget button in npcAttackButtons) {
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
        color: AppColors.uiColor.withAlpha(175),
        darkColor: AppColors.uiColorDark.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.npc!.defend();
        },
        resetAction: () {},
        resetArea: () {});
  }

  Widget createLookActionButton(User user) {
    int id = 2;
    return ActionButton(
        id: id,
        icon: AppImages.vision,
        color: AppColors.uiColor.withAlpha(175),
        darkColor: AppColors.uiColorDark.withAlpha(225),
        selected: checkSelectedButton(id),
        hide: hideButton(user, id),
        startAction: () {
          user.npc!.look();
        },
        resetAction: () {},
        resetArea: () {});
  }

  List<Widget> createNpcAttackButtons(User user) {
    List<Widget> npcAttackButtons = [];

    for (int i = 0; i < user.npc!.attacks.length; i++) {
      Attack attack = user.npc!.attacks[i];
      int id = 3 + i;

      if (attack.needsReload) {
        if (attack.isLoaded) {
          npcAttackButtons.add(createAttackButton(id, user, attack));
        } else {
          npcAttackButtons.add(createReloadButton(id, user, attack));
        }
      } else {
        npcAttackButtons.add(createAttackButton(id, user, attack));
      }
    }

    return npcAttackButtons;
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
        localRefresh();
      },
      resetAction: () {},
      resetArea: () {},
    );
  }

  Widget getAttackInput(User user, List<Npc> npcs, List<Player> players) {
    Widget attackInputWidget = MouseInput(
      active: (user.npcMode == 'action') ? true : false,
      getMouseOffset: (mouseOffset) {
        user.combat.setMousePosition(mouseOffset);
        user.combat.setActionArea();
        widget.fullRefresh();
      },
      onTap: () {
        deselectActionButton();
        user.combat.confirmAttack(npcs, players);
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
