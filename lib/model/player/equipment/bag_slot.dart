import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/view/player/inventory/widgets/inventory_slot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsix/shared/app_globals.dart';

class BagSlot extends StatefulWidget {
  final Function() refresh;

  const BagSlot({super.key, required this.refresh});

  @override
  State<BagSlot> createState() => _BagSlotState();
}

class _BagSlotState extends State<BagSlot> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return DragTarget<EquipmentSlot>(onWillAccept: (equipment) {
      if (equipment!.name == 'bag') {
        return false;
      } else {
        return true;
      }
    }, onAccept: (equipment) {
      user.player.equipment.unequip(equipment);
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
                    snackbarKey.currentState?.showSnackBar(AppSnackBar()
                        .getSnackBar(e.itemValue.toUpperCase(), user.color));
                  }

                  user.player.update();
                  widget.refresh();
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
