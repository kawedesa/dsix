import 'package:flutter/material.dart';

class AppSeparatorShortest extends StatelessWidget {
  final double value;
  const AppSeparatorShortest({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MediaQuery.of(context).size.width <
            MediaQuery.of(context).size.height)
        ? SizedBox(
            height: MediaQuery.of(context).size.shortestSide * value,
          )
        : SizedBox(
            width: MediaQuery.of(context).size.shortestSide * value,
          );
  }
}
