import 'package:dsix/model/item/bag_slot.dart';
import 'package:dsix/model/item/loot_slot.dart';

import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/shared_widgets/app_snackbar.dart';

class PlayerLootDialog extends StatefulWidget {
  final Player player;
  const PlayerLootDialog({
    super.key,
    required this.player,
  });

  @override
  State<PlayerLootDialog> createState() => _PlayerLootDialogState();
}

class _PlayerLootDialogState extends State<PlayerLootDialog> {
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
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
              items: widget.player.equipment.bag,
              onAccept: (equipment) {
                widget.player.equipment.addItemToBag(equipment.item);
                widget.player.update();
                user.player.equipment.removeItemWeight(equipment.item.weight);
                user.player.update();
                localRefresh();
              },
              onDragComplete: (item) {
                widget.player.removeItemFromBag(item);
                widget.player.update();
                localRefresh();
              },
              onDoubleTap: (equipment) {
                if (user.player.equipment.tooHeavy(equipment.item.weight)) {
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar('too heavy'.toUpperCase(), user.color));
                  return;
                }
                user.player.addItemToBag(equipment);
                user.player.update();
                widget.player.removeItemFromBag(equipment.item);
                widget.player.update();
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