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
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: size / 10,
          ),
        ),
        child: (selected)
            ? Center(
                child: Container(
                  width: size / 2,
                  height: size / 2,
                  color: color,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
