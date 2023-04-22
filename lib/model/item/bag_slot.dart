import 'package:dsix/model/item/equipment_slot.dart';
import 'package:dsix/model/item/item_dialog.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/model/item/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsix/shared/app_globals.dart';

class BagSlot extends StatelessWidget {
  final Function() refresh;
  final bool displayOnly;
  const BagSlot({super.key, required this.refresh, required this.displayOnly});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DragTarget<EquipmentSlot>(onWillAccept: (equipment) {
      if (equipment!.name == 'bag') {
        return false;
      }
      if (equipment.name != 'loot') {
        return true;
      }
      if (user.player.equipment.tooHeavy(equipment.item.weight)) {
        snackbarKey.currentState?.showSnackBar(
            AppSnackBar().getSnackBar('too heavy'.toUpperCase(), user.color));
        return false;
      } else {
        return true;
      }
    }, onAccept: (equipment) {
      if (equipment.item.name == 'gold') {
        user.player.addGold(equipment.item.value);
        snackbarKey.currentState?.showSnackBar(AppSnackBar().getSnackBar(
            '+\$${equipment.item.value}'.toUpperCase(), user.color));
      } else {
        user.player.addItemToBag(equipment);
      }
    }, builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
        color: Colors.black,
        child: Stack(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              crossAxisCount: 6,
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
              children:
                  List.generate(user.player.equipment.bag.length, (index) {
                EquipmentSlot equipmentSlot = EquipmentSlot(
                    name: 'bag', item: user.player.equipment.bag[index]);

                return InventorySlot(
                  player: user.player,
                  color: user.color,
                  darkColor: user.darkColor,
                  icon: AppImages().getItemIcon(equipmentSlot.item.name),
                  equipmentSlot: equipmentSlot,
                  onDragComplete: () {
                    user.player.removeItemFromBag(equipmentSlot.item);
                  },
                  onAccept: (equipment) {},
                  onWillAccept: (equipment) {
                    return false;
                  },
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ItemDialog(
                          color: user.color,
                          darkColor: user.darkColor,
                          item: equipmentSlot.item,
                          displayOnly: displayOnly,
                        );
                      },
                    ).then((value) => refresh());
                  },
                  onDoubleTap: (displayOnly)
                      ? () {}
                      : () {
                          user.player.quickEquip(equipmentSlot);
                          refresh();
                        },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
