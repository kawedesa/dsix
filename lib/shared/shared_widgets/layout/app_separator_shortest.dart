import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';

class AppSeparatorShortest extends StatelessWidget {
  final double value;
  const AppSeparatorShortest({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (AppLayout.width(context) < AppLayout.height(context))
        ? SizedBox(
            height: AppLayout.shortest(context) * value,
          )
        : SizedBox(
            width: AppLayout.shortest(context) * value,
          );
  }
}
