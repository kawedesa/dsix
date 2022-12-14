import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_widgets/inventory/inventory_slot.dart';
import 'package:flutter/material.dart';
import '../../model/player/equipment/equipment_slot.dart';
import '../../shared/app_images.dart';
import '../../shared/app_layout.dart';

class InventoryVM {
  InventorySlot? mainHandSlot;
  InventorySlot? offHandSlot;
  InventorySlot? headSlot;
  InventorySlot? bodySlot;
  InventorySlot? handSlot;
  InventorySlot? feetSlot;
  DragTarget<EquipmentSlot>? bagSlot;

  void setInventorySlots(User user, Function() refresh) {
    mainHandSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.mainHandSlot,
      equipmentSlot: user.player!.equipment.mainHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player!.equipment.offHandSlot) {
          user.player!.equipment.switchEquipments();
        } else {
          user.player!.equipment
              .equip(user.player!.equipment.mainHandSlot, equipment.item);
        }
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.mainHandSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'two hands' ||
            equipment.item.itemSlot == 'one hand') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.mainHandSlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );

    headSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.headSlot,
      equipmentSlot: user.player!.equipment.headSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player!.equipment
            .equip(user.player!.equipment.headSlot, equipment.item);
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.headSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'head') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.headSlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );

    bodySlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.bodySlot,
      equipmentSlot: user.player!.equipment.bodySlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player!.equipment
            .equip(user.player!.equipment.bodySlot, equipment.item);
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.bodySlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'body') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.bodySlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );

    offHandSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.offHandSlot,
      equipmentSlot: user.player!.equipment.offHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player!.equipment.mainHandSlot) {
          user.player!.equipment.switchEquipments();
        } else {
          user.player!.equipment
              .equip(user.player!.equipment.offHandSlot, equipment.item);
        }
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.offHandSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'two hands' ||
            equipment.item.itemSlot == 'one hand') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.offHandSlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );

    handSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.handSlot,
      equipmentSlot: user.player!.equipment.handSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player!.equipment
            .equip(user.player!.equipment.handSlot, equipment.item);
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.handSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'hands') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.handSlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );

    feetSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.feetSlot,
      equipmentSlot: user.player!.equipment.feetSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player!.equipment
            .equip(user.player!.equipment.feetSlot, equipment.item);
        user.player!.updatePlayer();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player!.equipment.feetSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'feet') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        user.player!.equipment.sellItem(user.player!.equipment.feetSlot);
        user.player!.updatePlayer();
        refresh();
      },
      useItem: () {},
    );
  }

  void setBagSlots(User user, Function() refresh) {
    bagSlot = DragTarget<EquipmentSlot>(onWillAccept: (equipment) {
      return true;
    }, onAccept: (equipment) {
      user.player!.equipment.unequip(equipment);
      user.player!.updatePlayer();
      refresh();
    }, builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Stack(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            crossAxisCount:
                (AppLayout.width(context) > AppLayout.height(context) * 0.8)
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
            crossAxisCount:
                (AppLayout.width(context) > AppLayout.height(context) * 0.8)
                    ? 14
                    : 7,
            children: List.generate(user.player!.equipment.bag.length, (index) {
              return InventorySlot(
                color: user.color,
                darkColor: user.darkColor,
                icon: user.player!.equipment.bag[index].icon,
                equipmentSlot: EquipmentSlot(
                    name: 'bag', item: user.player!.equipment.bag[index]),
                onDragComplete: () {
                  user.player!.equipment
                      .removeItemfromBag(user.player!.equipment.bag[index]);
                },
                onAccept: (equipment) {},
                onWillAccept: (equipment) {
                  return false;
                },
                sellItem: () {
                  user.player!.equipment.sellItem(EquipmentSlot(
                      name: 'bag', item: user.player!.equipment.bag[index]));
                  user.player!.updatePlayer();
                  refresh();
                },
                useItem: () {
                  // user.player!.equipment.useItem(EquipmentSlot(
                  //     name: 'bag', item: user.player!.equipment.bag[index]));
                },
              );
            }),
          ),
        ],
      );
    });
  }
}
