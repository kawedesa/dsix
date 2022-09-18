import 'package:dsix/shared/app_widgets/dialog/app_dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_title.dart';
import 'package:flutter/material.dart';

class AppConfirmDialog extends StatefulWidget {
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
  State<AppConfirmDialog> createState() => _AppConfirmDialogState();
}

class _AppConfirmDialogState extends State<AppConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.5,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.color,
            width: MediaQuery.of(context).size.shortestSide * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppDialogTitle(
              color: widget.color,
              title: widget.title,
            ),
            AppDialogButton(
              color: widget.color,
              buttonText: 'confirm',
              onTap: () {
                widget.confirm();
                Navigator.pop(context);
              },
            ),
            AppDialogButton(
                color: widget.color,
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
