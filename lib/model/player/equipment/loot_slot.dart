import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/model/player/equipment/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsix/shared/app_globals.dart';

class LootSlot extends StatefulWidget {
  final Npc npc;

  final Function() refresh;

  const LootSlot({super.key, required this.npc, required this.refresh});

  @override
  State<LootSlot> createState() => _LootSlotState();
}

class _LootSlotState extends State<LootSlot> {
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
      widget.npc.addItemToLoot(equipment.item);
      user.player.equipment.removeItemWeight(equipment.item);
      user.player.update();
      widget.refresh();
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
            children: List.generate(widget.npc.loot.length, (index) {
              return InventorySlot(
                color: user.color,
                darkColor: user.darkColor,
                icon: AppImages().getItemIcon(widget.npc.loot[index].name),
                equipmentSlot:
                    EquipmentSlot(name: 'loot', item: widget.npc.loot[index]),
                onDragComplete: () {
                  widget.npc.removeItemFromLoot(widget.npc.loot[index]);
                  widget.refresh();
                },
                onAccept: (equipment) {},
                onWillAccept: (equipment) {
                  return false;
                },
                sellItem: () {
                  // try {
                  //   user.player.equipment.sellItem(EquipmentSlot(
                  //       name: 'bag', item: widget.loot[index]));
                  // } on ItemSoldException catch (e) {
                  //   snackbarKey.currentState?.showSnackBar(AppSnackBar()
                  //       .getSnackBar(e.itemValue.toUpperCase(), user.color));
                  // }

                  // user.player.update();
                  // widget.refresh();
                },
                useItem: () {},
              );
            }),
          ),
        ],
      );
    });
  }
}
