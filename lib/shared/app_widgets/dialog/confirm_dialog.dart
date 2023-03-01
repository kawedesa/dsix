import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Color color;
  final String title;
  final Function() confirm;

  const ConfirmDialog({
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
        width: AppLayout.avarage(context) * 0.4,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: AppLayout.avarage(context) * 0.0025,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: color,
              title: title,
            ),
            DialogButton(
              color: color,
              buttonText: 'confirm',
              onTap: () {
                Navigator.pop(context);
                confirm();
              },
            ),
            DialogButton(
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
