import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/model/player/equipment/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropLootSlot extends StatefulWidget {
  final Prop prop;

  const PropLootSlot({super.key, required this.prop});

  @override
  State<PropLootSlot> createState() => _PropLootSlotState();
}

class _PropLootSlotState extends State<PropLootSlot> {
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
      widget.prop.addItemToLoot(equipment.item);
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
              children: List.generate(widget.prop.loot.length, (index) {
                return InventorySlot(
                  player: user.player,
                  color: user.color,
                  darkColor: user.darkColor,
                  icon: AppImages().getItemIcon(widget.prop.loot[index].name),
                  equipmentSlot: EquipmentSlot(
                      name: 'loot', item: widget.prop.loot[index]),
                  onDragComplete: () {
                    widget.prop.removeItemFromLoot(widget.prop.loot[index]);
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
