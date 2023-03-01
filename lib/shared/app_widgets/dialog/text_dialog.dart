import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  final Color color;
  final String title;
  final String dialogText;

  const TextDialog(
      {Key? key,
      required this.color,
      required this.title,
      required this.dialogText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.6,
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
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  const AppSeparatorVertical(value: 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.width(context) * 0.02),
                    child: AppText(
                      text: dialogText.toUpperCase(),
                      fontSize: 0.02,
                      letterSpacing: 0.004,
                      color: Colors.white,
                    ),
                  ),
                  const AppSeparatorVertical(value: 0.06),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
