import 'package:flutter/material.dart';

class AppSeparatorHorizontal extends StatelessWidget {
  final double value;
  const AppSeparatorHorizontal({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * value,
    );
  }
}
