import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppToggleButton extends StatelessWidget {
  final bool selected;
  final Color color;
  final double size;
  final Function() onTap;
  const AppToggleButton(
      {super.key,
      required this.selected,
      required this.color,
      required this.size,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: AppLayout.avarage(context) * size,
        height: AppLayout.avarage(context) * size,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: AppLayout.avarage(context) * size / 10,
          ),
        ),
        child: (selected)
            ? Center(
                child: Container(
                  width: AppLayout.avarage(context) * size / 2,
                  height: AppLayout.avarage(context) * size / 2,
                  color: color,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
