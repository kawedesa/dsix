import 'package:dsix/model/item/item_dialog.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/model/item/inventory_slot.dart';
import 'package:flutter/material.dart';
import '../../../shared/images/app_images.dart';

class InventoryVM {
  InventorySlot? mainHandSlot;
  InventorySlot? offHandSlot;
  InventorySlot? headSlot;
  InventorySlot? bodySlot;
  InventorySlot? handSlot;
  InventorySlot? feetSlot;

  void setInventorySlots(context, User user, Function() refresh) {
    mainHandSlot = InventorySlot(
      player: user.player,
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.mainHandSlot,
      equipmentSlot: user.player.equipment.mainHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player.equipment.offHandSlot) {
          user.player.switchEquipments();
          user.player.update();
        } else {
          user.player.equip(user.player.equipment.mainHandSlot, equipment.item);
          user.player.update();
        }
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.mainHandSlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.mainHandSlot);
        refresh();
      },
    );

    headSlot = InventorySlot(
      player: user.player,
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.headSlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.headSlot);
        refresh();
      },
    );

    bodySlot = InventorySlot(
      player: user.player,
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.bodySlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.bodySlot);
        refresh();
      },
    );

    offHandSlot = InventorySlot(
      player: user.player,
      color: user.color,
      darkColor: user.darkColor,
      icon: AppImages.offHandSlot,
      equipmentSlot: user.player.equipment.offHandSlot,
      onDragComplete: () {},
      onAccept: (equipment) {
        if (equipment == user.player.equipment.mainHandSlot) {
          user.player.switchEquipments();
          user.player.update();
        } else {
          user.player.equip(user.player.equipment.offHandSlot, equipment.item);
          user.player.update();
        }
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.offHandSlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.offHandSlot);
        refresh();
      },
    );

    handSlot = InventorySlot(
      player: user.player,
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.handSlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.handSlot);
        refresh();
      },
    );

    feetSlot = InventorySlot(
      player: user.player,
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
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ItemDialog(
              color: user.color,
              darkColor: user.darkColor,
              item: user.player.equipment.feetSlot.item,
              displayOnly: true,
            );
          },
        );
      },
      onDoubleTap: () {
        user.player.quickEquip(user.player.equipment.feetSlot);
        user.player.update();
        refresh();
      },
    );
  }
}
