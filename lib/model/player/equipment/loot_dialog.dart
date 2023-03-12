import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/player/equipment/bag_slot.dart';
import 'package:dsix/model/player/equipment/loot_slot.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LootDialog extends StatefulWidget {
  final Npc npc;
  final Function() refresh;

  const LootDialog({
    super.key,
    required this.npc,
    required this.refresh,
  });

  @override
  State<LootDialog> createState() => _LootDialogState();
}

class _LootDialogState extends State<LootDialog> {
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
            Container(
              color: Colors.black,
              child: LootSlot(
                npc: widget.npc,
                refresh: () {
                  setState(() {
                    widget.refresh();
                  });
                },
              ),
            ),
            DialogTitle(
              color: user.color,
              title: 'bag',
            ),
            Container(
              color: Colors.black,
              child: BagSlot(
                refresh: () {
                  setState(() {
                    widget.refresh();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
