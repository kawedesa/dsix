import 'package:dsix/model/item/bag_slot.dart';
import 'package:dsix/model/item/loot_slot.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChestLootDialog extends StatefulWidget {
  final int id;
  const ChestLootDialog({
    super.key,
    required this.id,
  });

  @override
  State<ChestLootDialog> createState() => _ChestLootDialogState();
}

class _ChestLootDialogState extends State<ChestLootDialog> {
  Chest _chest = Chest.empty();

  void updateChest(List<Chest> chests) {
    for (Chest chest in chests) {
      if (chest.id == widget.id) {
        _chest = chest;
      }
    }
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final chests = Provider.of<List<Chest>>(context);
    updateChest(chests);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.6,
        decoration: BoxDecoration(
          color: user.color,
          border: Border.all(
            color: user.color,
            width: AppLayout.avarage(context) * 0.0025,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: user.color,
              title: 'loot',
            ),
            LootSlot(
              items: _chest.loot,
              onAccept: (equipment) {
                _chest.addItemToLoot(equipment.item);
                _chest.update();
                user.player.equipment.removeItemWeight(equipment.item.weight);
                user.player.update();
                localRefresh();
              },
              onDragComplete: (item) {
                _chest.removeItemFromLoot(item);
                localRefresh();
              },
              onDoubleTap: (equipment) {
                if (user.player.equipment.tooHeavy(equipment.item.weight)) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar('too heavy'.toUpperCase(), user.color));
                  return;
                }

                if (equipment.item.name == 'gold') {
                  user.player.addGold(equipment.item.value);
                  user.player.update();
                  _chest.removeItemFromLoot(equipment.item);
                  _chest.update();
                  localRefresh();
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar('+\$${equipment.item.value}'.toUpperCase(),
                          user.color));
                  return;
                }
                user.player.addItemToBag(equipment);
                user.player.update();
                _chest.removeItemFromLoot(equipment.item);
                localRefresh();
              },
            ),
            DialogTitle(
              color: user.color,
              title: 'bag',
            ),
            BagSlot(
              displayOnly: true,
              refresh: () => localRefresh(),
            ),
          ],
        ),
      ),
    );
  }
}
