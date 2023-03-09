import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:flutter/material.dart';

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
          const AppSeparatorVertical(value: 0.002),
          Text(title.toUpperCase(),
              style: TextStyle(
                fontSize: AppLayout.avarage(context) * 0.015,
                fontWeight: FontWeight.bold,
                letterSpacing: AppLayout.avarage(context) * 0.005,
                fontFamily: 'Poppins',
                color: Colors.black,
              )),
          (subTitle == null)
              ? const SizedBox()
              : Column(
                  children: [
                    const AppSeparatorVertical(value: 0.001),
                    Text(subTitle!.toUpperCase(),
                        style: TextStyle(
                          fontSize: AppLayout.avarage(context) * 0.01,
                          fontWeight: FontWeight.normal,
                          letterSpacing: AppLayout.avarage(context) * 0.003,
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        )),
                  ],
                ),
          const AppSeparatorVertical(value: 0.0025),
        ],
      ),
    );
  }
}
