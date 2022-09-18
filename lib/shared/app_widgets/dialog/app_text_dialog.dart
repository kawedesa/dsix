import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_title.dart';
import 'package:flutter/material.dart';

class AppTextDialog extends StatefulWidget {
  final Color color;
  final String title;
  final String dialogText;

  const AppTextDialog(
      {Key? key,
      required this.color,
      required this.title,
      required this.dialogText})
      : super(key: key);

  @override
  State<AppTextDialog> createState() => _AppTextDialogState();
}

class _AppTextDialogState extends State<AppTextDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: MediaQuery.of(context).size.shortestSide * 0.6,
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
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  const AppSeparatorVertical(value: 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02),
                    child: Text(widget.dialogText.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.025,
                          fontWeight: FontWeight.w500,
                          letterSpacing:
                              MediaQuery.of(context).size.shortestSide * 0.008,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        )),
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
