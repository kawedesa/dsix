import 'package:dsix/model/item/bag_slot.dart';
import 'package:dsix/model/item/loot_slot.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropLootDialog extends StatefulWidget {
  final int id;
  const PropLootDialog({
    super.key,
    required this.id,
  });

  @override
  State<PropLootDialog> createState() => _PropLootDialogState();
}

class _PropLootDialogState extends State<PropLootDialog> {
  Prop _prop = Prop.empty();

  void updateProp(List<Prop> props) {
    for (Prop prop in props) {
      if (prop.id == widget.id) {
        _prop = prop;
      }
    }
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final props = Provider.of<List<Prop>>(context);
    updateProp(props);

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
              items: _prop.loot,
              onAccept: (equipment) {
                _prop.addItemToLoot(equipment.item);
                _prop.update();
                user.player.equipment.removeItemWeight(equipment.item.weight);
                user.player.update();
                localRefresh();
              },
              onDragComplete: (item) {
                _prop.removeItemFromLoot(item);
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
                  _prop.removeItemFromLoot(equipment.item);
                  _prop.update();
                  localRefresh();
                  snackbarKey.currentState?.showSnackBar(AppSnackBar()
                      .getSnackBar('+\$${equipment.item.value}'.toUpperCase(),
                          user.color));
                  return;
                }
                user.player.addItemToBag(equipment);
                user.player.update();
                _prop.removeItemFromLoot(equipment.item);
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
