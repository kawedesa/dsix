import 'package:dsix/model/player/equipment/bag_slot.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'prop_loot_slot.dart';

class PropLootDialog extends StatelessWidget {
  final Prop prop;
  const PropLootDialog({
    super.key,
    required this.prop,
  });

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
            PropLootSlot(
              prop: prop,
            ),
            DialogTitle(
              color: user.color,
              title: 'bag',
            ),
            // ignore: prefer_const_constructors
            BagSlot(),
          ],
        ),
      ),
    );
  }
}
