import 'package:dsix/shared/app_widgets/dialog/app_dialog_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_title.dart';
import 'package:flutter/material.dart';

class AppTextInputDialog extends StatefulWidget {
  final Color color;
  final String title;
  final Function(String) onConfirm;

  const AppTextInputDialog({
    Key? key,
    required this.color,
    required this.title,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<AppTextInputDialog> createState() => _AppTextInputDialogState();
}

class _AppTextInputDialogState extends State<AppTextInputDialog> {
  final textFieldController = TextEditingController();

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
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 5),
                    child: TextField(
                        controller: textFieldController,
                        autofocus: true,
                        cursorColor: widget.color,
                        textAlign: TextAlign.center,
                        onEditingComplete: () {
                          widget.onConfirm(textFieldController.text);
                        },
                        onSubmitted: (value) {
                          widget.onConfirm(value);
                        },
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide * 0.03,
                          fontWeight: FontWeight.w500,
                          letterSpacing:
                              MediaQuery.of(context).size.shortestSide * 0.008,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.color,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.color,
                              width: 1.5,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: widget.color,
                              width: 1.5,
                            ),
                          ),
                        )),
                  ),
                  const AppSeparatorVertical(value: 0.02),
                  AppDialogButton(
                      color: widget.color,
                      buttonText: 'confirm',
                      onTap: () => widget.onConfirm(textFieldController.text)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
