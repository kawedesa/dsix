import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/model/player/equipment/bag_slot.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/model/player/equipment/inventory_slot.dart';
import 'package:flutter/material.dart';
import '../../../shared/app_images.dart';

class InventoryVM {
  InventorySlot? mainHandSlot;
  InventorySlot? offHandSlot;
  InventorySlot? headSlot;
  InventorySlot? bodySlot;
  InventorySlot? handSlot;
  InventorySlot? feetSlot;

  void setInventorySlots(User user, Function() refresh) {
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
          user.player.equip(user.player.equipment.mainHandSlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.mainHandSlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

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
        user.player.equip(user.player.equipment.headSlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.headSlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

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
        user.player.equip(user.player.equipment.bodySlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.bodySlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

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
          user.player.equip(user.player.equipment.offHandSlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.offHandSlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

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
        user.player.equip(user.player.equipment.handSlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.handSlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

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
        user.player.equip(user.player.equipment.feetSlot, equipment.item);
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
          user.player.sellItem(user.player.equipment.feetSlot);
        } on ItemSoldException catch (e) {
          snackbarKey.currentState?.showSnackBar(
              AppSnackBar().getSnackBar(e.itemValue.toUpperCase(), user.color));
        }

        refresh();
      },
      useItem: () {},
    );
  }

  Widget getBagSlots(Function() refresh) {
    return BagSlot(refresh: refresh);
  }
}
