import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_shortest.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatefulWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
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
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: '${user.player!.attack}',
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: '${user.player!.attack}',
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: '${user.player!.attack}',
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: '${user.player!.attack}',
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 2),
        const AppSeparatorVertical(
          value: 0.025,
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSeparatorHorizontal(value: 0.05),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.5,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.25,
                    color: user.color,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.25,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.5,
                    color: user.color,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.5,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.shortestSide * 0.25,
                    height: MediaQuery.of(context).size.shortestSide * 0.25,
                    color: user.color,
                  ),
                ],
              ),
              const AppSeparatorHorizontal(value: 0.05),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.025,
        ),
        AppLineDividerHorizontal(color: user.color, value: 2),
      ],
    );
  }
}
