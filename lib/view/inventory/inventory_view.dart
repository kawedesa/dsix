import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/inventory/inventory_slot.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/player/player_sprite.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatefulWidget {
  final Function() refresh;
  const InventoryView({Key? key, required this.refresh}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppSeparatorVertical(
          value: 0.02,
        ),
        SizedBox(
          width: AppLayout.shortest(context) * 0.8,
          height: AppLayout.height(context) * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.damage.pDamage.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.armor.pArmor.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.damage.mDamage.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.armor.mArmor.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 4),
        Expanded(
          child: Stack(
            children: [
              (AppLayout.width(context) > AppLayout.height(context) * 0.55)
                  ? Align(
                      alignment: const Alignment(0.0, -0.75),
                      child: SizedBox(
                        width: AppLayout.width(context) * 0.9,
                        height: AppLayout.height(context) * 0.45,
                        child: (AppLayout.width(context) >
                                AppLayout.height(context) * 1.25)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: AppLayout.avarage(context) * 0.25,
                                    height: AppLayout.avarage(context) * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.mainHandSlot,
                                              equipmentSlot: user.player!
                                                  .equipment.mainHandSlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.headSlot,
                                              equipmentSlot: user
                                                  .player!.equipment.headSlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.handSlot,
                                              equipmentSlot: user
                                                  .player!.equipment.handSlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                            Container(
                                              width:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              height:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: user.color,
                                                  width: AppLayout.shortest(
                                                          context) *
                                                      0.005,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  PlayerSprite(race: user.player!.race),
                                  SizedBox(
                                    width: AppLayout.avarage(context) * 0.25,
                                    height: AppLayout.avarage(context) * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.bodySlot,
                                              equipmentSlot: user
                                                  .player!.equipment.bodySlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.offHandSlot,
                                              equipmentSlot: user.player!
                                                  .equipment.offHandSlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              height:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: user.color,
                                                  width: AppLayout.shortest(
                                                          context) *
                                                      0.005,
                                                ),
                                              ),
                                            ),
                                            InventorySlot(
                                              color: user.color,
                                              icon: AppImages.feetSlot,
                                              equipmentSlot: user
                                                  .player!.equipment.feetSlot,
                                              onDragComplete: () {},
                                              onAccept: (equipment) {},
                                              onWillAccept: (equipment) {
                                                return true;
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.headSlot,
                                        equipmentSlot:
                                            user.player!.equipment.headSlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.mainHandSlot,
                                        equipmentSlot:
                                            user.player!.equipment.mainHandSlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.handSlot,
                                        equipmentSlot:
                                            user.player!.equipment.handSlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      Container(
                                        width:
                                            AppLayout.avarage(context) * 0.12,
                                        height:
                                            AppLayout.avarage(context) * 0.12,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: user.color,
                                            width: AppLayout.shortest(context) *
                                                0.005,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  PlayerSprite(race: user.player!.race),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.bodySlot,
                                        equipmentSlot:
                                            user.player!.equipment.bodySlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.offHandSlot,
                                        equipmentSlot:
                                            user.player!.equipment.offHandSlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      InventorySlot(
                                        color: user.color,
                                        icon: AppImages.feetSlot,
                                        equipmentSlot:
                                            user.player!.equipment.feetSlot,
                                        onDragComplete: () {},
                                        onAccept: (equipment) {},
                                        onWillAccept: (equipment) {
                                          return true;
                                        },
                                      ),
                                      Container(
                                        width:
                                            AppLayout.avarage(context) * 0.12,
                                        height:
                                            AppLayout.avarage(context) * 0.12,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: user.color,
                                            width: AppLayout.shortest(context) *
                                                0.005,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    )
                  : Align(
                      alignment: Alignment(
                          0.0, -0.5 - (AppLayout.width(context) * 0.0005)),
                      child: SizedBox(
                        width: AppLayout.shortest(context) * 0.9,
                        height: AppLayout.avarage(context) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.mainHandSlot,
                                  equipmentSlot:
                                      user.player!.equipment.mainHandSlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.mainHandSlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.mainHandSlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.mainHandSlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot ==
                                            'two hands' ||
                                        equipment.item.itemSlot == 'one hand') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.headSlot,
                                  equipmentSlot:
                                      user.player!.equipment.headSlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.headSlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.headSlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.headSlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot == 'head') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.bodySlot,
                                  equipmentSlot:
                                      user.player!.equipment.bodySlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.bodySlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.bodySlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.bodySlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot == 'body') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.offHandSlot,
                                  equipmentSlot:
                                      user.player!.equipment.offHandSlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.offHandSlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.offHandSlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.offHandSlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot ==
                                            'two hands' ||
                                        equipment.item.itemSlot == 'one hand') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                              ],
                            ),
                            PlayerSprite(race: user.player!.race),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.handSlot,
                                  equipmentSlot:
                                      user.player!.equipment.handSlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.handSlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.handSlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.handSlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot == 'hands') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                                Container(
                                  width: AppLayout.avarage(context) * 0.12,
                                  height: AppLayout.avarage(context) * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: user.color,
                                      width:
                                          AppLayout.shortest(context) * 0.005,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: AppLayout.avarage(context) * 0.12,
                                  height: AppLayout.avarage(context) * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: user.color,
                                      width:
                                          AppLayout.shortest(context) * 0.005,
                                    ),
                                  ),
                                ),
                                InventorySlot(
                                  color: user.color,
                                  icon: AppImages.feetSlot,
                                  equipmentSlot:
                                      user.player!.equipment.feetSlot,
                                  onDragComplete: () {
                                    user.player!.equipment.unequip(
                                        user.player!.equipment.feetSlot);
                                  },
                                  onAccept: (equipment) {
                                    user.player!.equipment.equip(
                                        user.player!.equipment.feetSlot,
                                        equipment.item);
                                    user.player!.updatePlayer();
                                    widget.refresh();
                                  },
                                  onWillAccept: (equipment) {
                                    if (equipment ==
                                        user.player!.equipment.feetSlot) {
                                      return false;
                                    }
                                    if (equipment.item.itemSlot == 'feet') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Stack(
                  children: [
                    GridView.count(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      crossAxisCount: (AppLayout.width(context) >
                              AppLayout.height(context) * 0.8)
                          ? 14
                          : 7,
                      children: List.generate(14, (index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: user.color,
                              width: AppLayout.shortest(context) * 0.004,
                            ),
                          ),
                        );
                      }),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      crossAxisCount: (AppLayout.width(context) >
                              AppLayout.height(context) * 0.8)
                          ? 14
                          : 7,
                      children: List.generate(user.player!.equipment.bag.length,
                          (index) {
                        return InventorySlot(
                          color: user.color,
                          icon: user.player!.equipment.bag[index].icon,
                          equipmentSlot: EquipmentSlot(
                              name: 'bag',
                              item: user.player!.equipment.bag[index]),
                          onDragComplete: () {
                            user.player!.equipment.removeItemfromBag(
                                user.player!.equipment.bag[index]);
                          },
                          onAccept: (equipment) {
                            user.player!.equipment.addItemToBag(equipment.item);
                            user.player!.updatePlayer();
                            widget.refresh();
                          },
                          onWillAccept: (equipment) {
                            return true;
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
