import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/ui/action_button.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerActioButtons extends StatefulWidget {
  final MapInfo mapInfo;
  final Function() refresh;

  const PlayerActioButtons(
      {super.key, required this.mapInfo, required this.refresh});

  @override
  State<PlayerActioButtons> createState() => _PlayerActioButtonsState();
}

class _PlayerActioButtonsState extends State<PlayerActioButtons> {
  Widget createActionButtons(User user) {
    List<Widget> actionButtons = [];
    List<Widget> mainHandActionButtons = createMainHandActionButtons(user);
    List<Widget> offHandActionButtons = createOffHandActionButtons(user);

    for (Widget button in mainHandActionButtons) {
      actionButtons.add(button);
    }

    actionButtons.add(createDefendActionButton(user));
    actionButtons.add(createLookActionButton(user));

    for (Widget button in offHandActionButtons) {
      actionButtons.add(button);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actionButtons,
    );
  }

  Widget createDefendActionButton(User user) {
    return AppCircularButton(
      icon: AppImages.defense,
      iconColor: user.darkColor.withAlpha(225),
      color: user.color.withAlpha(175),
      borderColor: user.darkColor.withAlpha(225),
      size: 0.04,
      onTap: () {
        user.player.defend();
        widget.refresh();
      },
    );
  }

  Widget createLookActionButton(User user) {
    return AppCircularButton(
      icon: AppImages.vision,
      iconColor: user.darkColor.withAlpha(225),
      color: user.color.withAlpha(175),
      borderColor: user.darkColor.withAlpha(225),
      size: 0.04,
      onTap: () {
        user.player.look();
        widget.refresh();
      },
    );
  }

  List<Widget> createMainHandActionButtons(User user) {
    List<Widget> mainHandActionButtons = [];

    for (Attack attack in user.player.equipment.mainHandSlot.item.attacks) {
      mainHandActionButtons.add(ActionButton(
        icon: AppImages().getActionIcon(attack.name),
        color: user.color,
        darkColor: user.darkColor,
        isTakingAction: user.combat.isTakingAction,
        startAction: () {
          user.combat.startAttack(
              widget.mapInfo.getOnScreenPosition(user.player.position),
              user.player.position,
              user.player.attack(attack),
              user.player,
              null);

          user.playerActionMode();
          widget.refresh();
        },
        resetAction: () {
          user.combat.resetAction();
          user.playerStandMode();
        },
        resetArea: () {
          user.combat.resetArea();
          widget.refresh();
        },
      ));
    }

    return mainHandActionButtons;
  }

  List<Widget> createOffHandActionButtons(User user) {
    List<Widget> offHandActionButtons = [];

    if (user.player.equipment.offHandSlot.item.itemSlot == 'two hands') {
      return offHandActionButtons;
    }

    for (Attack attack in user.player.equipment.offHandSlot.item.attacks) {
      offHandActionButtons.add(ActionButton(
        icon: AppImages().getActionIcon(attack.name),
        color: user.color,
        darkColor: user.darkColor,
        isTakingAction: user.combat.isTakingAction,
        startAction: () {
          user.combat.startAttack(
              widget.mapInfo.getOnScreenPosition(user.player.position),
              user.player.position,
              user.player.attack(attack),
              user.player,
              null);

          user.playerActionMode();
          widget.refresh();
        },
        resetAction: () {
          user.combat.resetAction();
          user.playerStandMode();
        },
        resetArea: () {
          user.combat.resetArea();
          widget.refresh();
        },
      ));
    }

    return offHandActionButtons;
  }

  Widget getAttackInput(
      User user, List<Npc> npcs, List<Player> players, Function refresh) {
    Widget attackInputWidget = const SizedBox();

    attackInputWidget = MouseInput(
      active: user.combat.isTakingAction,
      getMouseOffset: (mouseOffset) {
        user.combat.setMousePosition(mouseOffset);
        user.combat.setActionArea();
        refresh();
      },
      onTap: () {
        user.combat.confirmAttack(npcs, players);
        user.combat.resetAction();
        user.playerStandMode();
        refresh();
      },
    );

    return attackInputWidget;
  }

  //TODO VOLTAR AQUI PARA IMPLEMENTAR OS BOTOES QUE SOMEN QUANDO O PLAYER ESTA ATACANDO

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
          getAttackInput(user, npcs, players, widget.refresh),
          (user.player.life.isDead() || user.playerMode == 'wait')
              ? const SizedBox()
              : Align(
                  alignment: const Alignment(0, 0.50),
                  child: SizedBox(
                      width: AppLayout.shortest(context) * 0.50,
                      height: AppLayout.shortest(context) * 0.1,
                      child: createActionButtons(user))),
        ],
      ),
    );
  }
}
