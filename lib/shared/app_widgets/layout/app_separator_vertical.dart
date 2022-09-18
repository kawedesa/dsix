import 'package:flutter/material.dart';

class AppSeparatorVertical extends StatelessWidget {
  final double value;
  const AppSeparatorVertical({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * value,
    );
  }
}
