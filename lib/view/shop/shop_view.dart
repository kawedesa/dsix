import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Column(
      children: [
        const AppSeparatorVertical(
          value: 0.02,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.shortestSide * 0.8,
          height: MediaQuery.of(context).size.shortestSide * 0.075,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppCircularButton(
                  color: user.color, borderColor: user.color, size: 0.075),
              AppCircularButton(
                  color: user.color, borderColor: user.color, size: 0.075),
              AppCircularButton(
                  color: user.color, borderColor: user.color, size: 0.075),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 2),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppTitle(title: 'shop', color: user.color)
      ],
    );
  }
}
