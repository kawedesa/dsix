import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_title.dart';
import 'package:flutter/material.dart';

class AppConfirmDialog extends StatelessWidget {
  final Color color;
  final String title;
  final Function() confirm;

  const AppConfirmDialog({
    Key? key,
    required this.color,
    required this.title,
    required this.confirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.5,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppDialogTitle(
              color: color,
              title: title,
            ),
            AppDialogButton(
              color: color,
              buttonText: 'confirm',
              onTap: () {
                confirm();
                Navigator.pop(context);
              },
            ),
            AppDialogButton(
                color: color,
                buttonText: 'cancel',
                onTap: () {
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
