import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:flutter/material.dart';

import '../text/app_text.dart';

class DialogTitle extends StatelessWidget {
  final Color color;
  final String title;
  final String? subTitle;

  const DialogTitle(
      {Key? key, required this.color, required this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSeparatorVertical(value: 0.01),
          Text(title.toUpperCase(),
              style: TextStyle(
                fontSize: AppLayout.shortest(context) * 0.035,
                fontWeight: FontWeight.bold,
                letterSpacing: AppLayout.shortest(context) * 0.005,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
          (subTitle == null)
              ? const SizedBox()
              : Column(
                  children: [
                    const AppSeparatorVertical(value: 0.0025),
                    AppText(
                      text: subTitle!.toUpperCase(),
                      fontSize: 0.02,
                      letterSpacing: 0.002,
                      color: Colors.black,
                    ),
                  ],
                ),
          const AppSeparatorVertical(value: 0.01),
        ],
      ),
    );
  }
}
