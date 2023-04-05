import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/ui/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NpcActionButtons extends StatefulWidget {
  final Function() refresh;

  const NpcActionButtons({super.key, required this.refresh});

  @override
  State<NpcActionButtons> createState() => _NpcActionButtonsState();
}

class _NpcActionButtonsState extends State<NpcActionButtons> {
  Widget createActionButtons(User user) {
    List<Widget> actionButtons = [];
    List<Widget> npcAttackButtons = createNpcAttackButtons(user);

    actionButtons.add(createDefendActionButton(user));

    for (Widget button in npcAttackButtons) {
      actionButtons.add(button);
    }
    actionButtons.add(createLookActionButton(user));

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actionButtons,
    );
  }

  //TODO ADD ID TO ACTION BUTTON
  //ADD HIDE PARAMETER TO BUTTON
  //CHECK ID TO MAKE BUTTON HIDE

  Widget createDefendActionButton(User user) {
    return AppCircularButton(
      icon: AppImages.defense,
      iconColor: AppColors.uiColorDark.withAlpha(225),
      color: AppColors.uiColor.withAlpha(175),
      borderColor: AppColors.uiColorDark.withAlpha(225),
      size: 0.04,
      onTap: () {
        user.npc!.defend();
        widget.refresh();
      },
    );
  }

  Widget createLookActionButton(User user) {
    return AppCircularButton(
      icon: AppImages.vision,
      iconColor: AppColors.uiColorDark.withAlpha(225),
      color: AppColors.uiColor.withAlpha(175),
      borderColor: AppColors.uiColorDark.withAlpha(225),
      size: 0.04,
      onTap: () {
        user.npc!.look();
        widget.refresh();
      },
    );
  }

  List<Widget> createNpcAttackButtons(User user) {
    List<Widget> npcAttackButtons = [];

    for (Attack attack in user.npc!.attacks) {
      npcAttackButtons.add(ActionButton(
        icon: AppImages().getActionIcon(attack.name),
        color: AppColors.uiColor.withAlpha(175),
        darkColor: AppColors.uiColorDark.withAlpha(225),
        isTakingAction: user.combat.isTakingAction,
        startAction: () {
          user.combat.startAttack(
              user.mapInfo.getOnScreenPosition(user.npc!.position),
              user.npc!.position,
              user.npc!.attack(attack),
              null,
              user.npc!);

          user.npcActionMode();
          widget.refresh();
        },
        resetAction: () {
          user.combat.resetAction();
          user.npcStandMode();
        },
        resetArea: () {
          user.combat.resetArea();
          widget.refresh();
        },
      ));
    }

    return npcAttackButtons;
  }

  Widget getAttackInput(
      User user, List<Npc> npcs, List<Player> players, Function refresh) {
    Widget attackInputWidget = MouseInput(
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
          (user.npc == null || user.npcMode == 'wait')
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
