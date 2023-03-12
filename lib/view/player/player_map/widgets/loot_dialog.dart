import 'package:dsix/model/item/item.dart';
import 'package:dsix/shared/app_colors.dart';

import 'package:dsix/shared/app_layout.dart';

import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';

class LootDialog extends StatefulWidget {
  final List<Item> loot;

  const LootDialog({
    super.key,
    required this.loot,
  });

  @override
  State<LootDialog> createState() => _LootDialogState();
}

class _LootDialogState extends State<LootDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.6,
        decoration: BoxDecoration(
          color: AppColors.uiColor,
          border: Border.all(
            color: AppColors.uiColor,
            width: AppLayout.avarage(context) * 0.0025,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const DialogTitle(
              color: AppColors.uiColor,
              title: 'loot',
            ),
            Container(
              color: Colors.black,
              width: AppLayout.avarage(context) * 0.6,
              height: AppLayout.avarage(context) * 0.375,
            ),
          ],
        ),
      ),
    );
  }
}
