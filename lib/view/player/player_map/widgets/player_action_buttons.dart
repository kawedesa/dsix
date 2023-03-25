import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/map/attack_button.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:flutter/material.dart';

class PlayerActioButtons extends StatefulWidget {
  final MapInfo mapInfo;
  final User user;
  final String playerMode;
  final Combat combat;
  final Function() cancelAction;
  final Function() changePlayerMode;
  final Function() refresh;

  const PlayerActioButtons(
      {super.key,
      required this.mapInfo,
      required this.user,
      required this.playerMode,
      required this.combat,
      required this.cancelAction,
      required this.changePlayerMode,
      required this.refresh});

  @override
  State<PlayerActioButtons> createState() => _PlayerActioButtonsState();
}

class _PlayerActioButtonsState extends State<PlayerActioButtons> {
  int selectedAction = 0;

  void selectAction(int value) {
    selectedAction = value;
  }

  void deselectAction() {
    selectedAction = 0;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.playerMode == 'stand') {
      selectedAction = 0;
    }

    return (widget.user.player.life.isDead())
        ? const SizedBox()
        : Align(
            alignment: const Alignment(0, 0.50),
            child: SizedBox(
              width: AppLayout.shortest(context) * 0.50,
              height: AppLayout.shortest(context) * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (selectedAction == 0 || selectedAction == 1)
                      ? AttackButton(
                          isAttacking:
                              (widget.combat.isAttacking) ? true : false,
                          icon: AppImages().getItemIcon(widget
                              .user.player.equipment.mainHandSlot.item.name),
                          color: widget.user.color,
                          darkColor: widget.user.darkColor,
                          resetAttack: () {
                            widget.combat.resetActionArea();
                            widget.refresh();
                          },
                          startAttack: () {
                            widget.combat.startAttack(
                                widget.mapInfo.getPlayerOnScreenPosition(
                                    widget.user.player.position),
                                widget.user.player.position,
                                widget.user.player.attack(widget.user.player
                                    .equipment.mainHandSlot.item.attack),
                                widget.user.player,
                                null);

                            widget.changePlayerMode();
                            selectAction(1);
                            widget.refresh();
                          },
                          cancelAttack: () {
                            widget.cancelAction();
                            deselectAction();
                            widget.refresh();
                          },
                        )
                      : const SizedBox(),
                  (selectedAction != 0)
                      ? const SizedBox()
                      : AppCircularButton(
                          icon: AppImages.defense,
                          iconColor: widget.user.darkColor.withAlpha(225),
                          color: widget.user.color.withAlpha(175),
                          borderColor: widget.user.darkColor.withAlpha(225),
                          size: 0.04,
                          onTap: () {
                            widget.user.player.defend();
                            widget.refresh();
                          },
                        ),
                  (selectedAction != 0)
                      ? const SizedBox()
                      : AppCircularButton(
                          icon: AppImages.vision,
                          iconColor: widget.user.darkColor.withAlpha(225),
                          color: widget.user.color.withAlpha(175),
                          borderColor: widget.user.darkColor.withAlpha(225),
                          size: 0.04,
                          onTap: () {
                            widget.user.player.look();
                            widget.refresh();
                          },
                        ),
                  (selectedAction == 0 || selectedAction == 2)
                      ? AttackButton(
                          isAttacking:
                              (widget.combat.isAttacking) ? true : false,
                          color: widget.user.color,
                          darkColor: widget.user.darkColor,
                          icon: AppImages().getItemIcon(widget
                              .user.player.equipment.offHandSlot.item.name),
                          resetAttack: () {
                            widget.combat.resetActionArea();
                            widget.refresh();
                          },
                          startAttack: () {
                            widget.combat.startAttack(
                              widget.mapInfo.getPlayerOnScreenPosition(
                                  widget.user.player.position),
                              widget.user.player.position,
                              widget.user.player.attack(widget.user.player
                                  .equipment.offHandSlot.item.attack),
                              widget.user.player,
                              null,
                            );
                            widget.changePlayerMode();
                            selectAction(2);
                            widget.refresh();
                          },
                          cancelAttack: () {
                            widget.cancelAction();
                            deselectAction();
                            widget.refresh();
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ));
  }
}
