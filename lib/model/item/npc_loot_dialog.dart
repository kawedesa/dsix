import 'package:dsix/model/item/bag_slot.dart';
import 'package:dsix/model/item/loot_slot.dart';

import 'package:dsix/model/npc/npc.dart';

import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NpcLootDialog extends StatefulWidget {
  final int id;
  const NpcLootDialog({
    super.key,
    required this.id,
  });

  @override
  State<NpcLootDialog> createState() => _NpcLootDialogState();
}

class _NpcLootDialogState extends State<NpcLootDialog> {
  Npc _npc = Npc.empty();

  void updateNpc(List<Npc> npcs) {
    for (Npc npc in npcs) {
      if (npc.id == widget.id) {
        _npc = npc;
      }
    }
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final npcs = Provider.of<List<Npc>>(context);
    updateNpc(npcs);

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
              items: _npc.loot,
              onAccept: (equipment) {
                _npc.addItemToLoot(equipment.item);
                _npc.update();
                user.player.equipment.removeItemWeight(equipment.item.weight);
                user.player.update();
                localRefresh();
              },
              onDragComplete: (item) {
                _npc.removeItemFromLoot(item);
                _npc.update();
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
                  _npc.removeItemFromLoot(equipment.item);
                  _npc.update();
                  localRefresh();
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar('+\$${equipment.item.value}'.toUpperCase(),
                          user.color));
                  return;
                }

                user.player.addItemToBag(equipment);
                user.player.update();
                _npc.removeItemFromLoot(equipment.item);
                _npc.update();
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
