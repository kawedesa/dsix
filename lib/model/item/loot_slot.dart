import 'package:dsix/model/item/equipment_slot.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/item_dialog.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/model/item/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LootSlot extends StatelessWidget {
  final List<Item> items;
  final Function(EquipmentSlot) onAccept;
  final Function(Item) onDragComplete;
  final Function(EquipmentSlot) onDoubleTap;

  const LootSlot({
    super.key,
    required this.items,
    required this.onAccept,
    required this.onDragComplete,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DragTarget<EquipmentSlot>(onWillAccept: (equipment) {
      if (equipment!.name == 'loot') {
        return false;
      } else {
        return true;
      }
    }, onAccept: (equipment) {
      onAccept(equipment);
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
              children: List.generate(items.length, (index) {
                EquipmentSlot equipmentSlot =
                    EquipmentSlot(name: 'loot', item: items[index]);

                return InventorySlot(
                  player: user.player,
                  color: user.color,
                  darkColor: user.darkColor,
                  icon: AppImages().getItemIcon(items[index].name),
                  equipmentSlot: equipmentSlot,
                  onDragComplete: () {
                    onDragComplete(items[index]);
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
                          item: items[index],
                          displayOnly: true,
                        );
                      },
                    );
                  },
                  onDoubleTap: () {
                    onDoubleTap(equipmentSlot);
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
//TODO AJUSTAR A SINCRONIA DO LOOT SLOT
//TODO AJUSTAR O DUPLO CLICK NO DINHEIRO