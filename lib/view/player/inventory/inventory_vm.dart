import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/view/player/inventory/widgets/inventory_slot.dart';
import 'package:flutter/material.dart';
import '../../../model/player/equipment/equipment_slot.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_layout.dart';

class InventoryVM {
  InventorySlot? mainHandSlot;
  InventorySlot? offHandSlot;
  InventorySlot? headSlot;
  InventorySlot? bodySlot;
  InventorySlot? handSlot;
  InventorySlot? feetSlot;
  DragTarget<EquipmentSlot>? bagSlot;

  void setInventorySlots(
      User user, Function() refresh, Function(String, Color) displaySnackbar) {
    mainHandSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.mainHandSlot,
      equipmentSlot: user.player.equipment.mainHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player.equipment.offHandSlot) {
          user.player.equipment.switchEquipments();
        } else {
          user.player.equipment
              .equip(user.player.equipment.mainHandSlot, equipment.item);
        }
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.mainHandSlot) {
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
        try {
          user.player.equipment.sellItem(user.player.equipment.mainHandSlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }

        user.player.update();
        refresh();
      },
      useItem: () {},
    );

    headSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.headSlot,
      equipmentSlot: user.player.equipment.headSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player.equipment
            .equip(user.player.equipment.headSlot, equipment.item);
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.headSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'head') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        try {
          user.player.equipment.sellItem(user.player.equipment.headSlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }

        user.player.update();
        refresh();
      },
      useItem: () {},
    );

    bodySlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.bodySlot,
      equipmentSlot: user.player.equipment.bodySlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player.equipment
            .equip(user.player.equipment.bodySlot, equipment.item);
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.bodySlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'body') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        try {
          user.player.equipment.sellItem(user.player.equipment.bodySlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }

        user.player.update();
        refresh();
      },
      useItem: () {},
    );

    offHandSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.offHandSlot,
      equipmentSlot: user.player.equipment.offHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player.equipment.mainHandSlot) {
          user.player.equipment.switchEquipments();
        } else {
          user.player.equipment
              .equip(user.player.equipment.offHandSlot, equipment.item);
        }
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.offHandSlot) {
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
        try {
          user.player.equipment.sellItem(user.player.equipment.offHandSlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }

        user.player.update();
        refresh();
      },
      useItem: () {},
    );

    handSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.handSlot,
      equipmentSlot: user.player.equipment.handSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player.equipment
            .equip(user.player.equipment.handSlot, equipment.item);
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.handSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'hands') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        try {
          user.player.equipment.sellItem(user.player.equipment.handSlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }

        user.player.update();
        refresh();
      },
      useItem: () {},
    );

    feetSlot = InventorySlot(
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.feetSlot,
      equipmentSlot: user.player.equipment.feetSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        user.player.equipment
            .equip(user.player.equipment.feetSlot, equipment.item);
        user.player.update();
        refresh();
      },
      onWillAccept: (equipment) {
        if (equipment == user.player.equipment.feetSlot) {
          return false;
        }
        if (equipment.item.itemSlot == 'feet') {
          return true;
        } else {
          return false;
        }
      },
      sellItem: () {
        try {
          user.player.equipment.sellItem(user.player.equipment.feetSlot);
        } on ItemSoldException catch (e) {
          displaySnackbar(e.itemValue.toUpperCase(), user.color);
        }
        user.player.update();
        refresh();
      },
      useItem: () {},
    );
  }

  void setBagSlots(
      User user, Function() refresh, Function(String, Color) displaySnackbar) {
    bagSlot = DragTarget<EquipmentSlot>(onWillAccept: (equipment) {
      return true;
    }, onAccept: (equipment) {
      user.player.equipment.unequip(equipment);
      user.player.update();
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
            crossAxisCount: 6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(12, (index) {
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
            crossAxisCount: 6,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: List.generate(user.player.equipment.bag.length, (index) {
              return InventorySlot(
                color: user.color,
                darkColor: user.darkColor,
                icon: AppImages()
                    .getItemIcon(user.player.equipment.bag[index].name),
                equipmentSlot: EquipmentSlot(
                    name: 'bag', item: user.player.equipment.bag[index]),
                onDragComplete: () {
                  user.player.equipment
                      .removeItemfromBag(user.player.equipment.bag[index]);
                  user.player.update();
                },
                onAccept: (equipment) {},
                onWillAccept: (equipment) {
                  return false;
                },
                sellItem: () {
                  try {
                    user.player.equipment.sellItem(EquipmentSlot(
                        name: 'bag', item: user.player.equipment.bag[index]));
                  } on ItemSoldException catch (e) {
                    displaySnackbar(e.itemValue.toUpperCase(), user.color);
                  }

                  user.player.update();
                  refresh();
                },
                useItem: () {
                  //TODO implement use items

                  // user.player.equipment.useItem(EquipmentSlot(
                  //     name: 'bag', item: user.player.equipment.bag[index]));
                },
              );
            }),
          ),
        ],
      );
    });
  }
}
