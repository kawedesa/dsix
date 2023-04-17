import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/model/player/equipment/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NpcLootSlot extends StatefulWidget {
  final Npc npc;

  const NpcLootSlot({super.key, required this.npc});

  @override
  State<NpcLootSlot> createState() => _NpcLootSlotState();
}

class _NpcLootSlotState extends State<NpcLootSlot> {
  void localRefresh() {
    setState(() {});
  }

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
      user.player.equipment.removeItemWeight(equipment.item.weight);
      user.player.update();
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
              children: List.generate(widget.npc.loot.length, (index) {
                return InventorySlot(
                  player: user.player,
                  color: user.color,
                  darkColor: user.darkColor,
                  icon: AppImages().getItemIcon(widget.npc.loot[index].name),
                  equipmentSlot:
                      EquipmentSlot(name: 'loot', item: widget.npc.loot[index]),
                  onDragComplete: () {
                    widget.npc.removeItemFromLoot(widget.npc.loot[index]);
                    localRefresh();
                  },
                  onAccept: (equipment) {},
                  onWillAccept: (equipment) {
                    return false;
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
