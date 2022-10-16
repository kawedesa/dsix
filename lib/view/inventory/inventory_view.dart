import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          width: AppLayout.shortest(context) * 0.8,
          height: AppLayout.height(context) * 0.06,
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
                      text: user.player!.equipment.damage.pDamage.toString(),
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
                      text: user.player!.equipment.armor.pArmor.toString(),
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
                      text: user.player!.equipment.damage.mDamage.toString(),
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
                      text: user.player!.equipment.armor.mArmor.toString(),
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
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.3,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.2,
                    color: user.color,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.2,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.3,
                    color: user.color,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.3,
                    color: user.color,
                  ),
                  const AppSeparatorVertical(
                    value: 0.02,
                  ),
                  Container(
                    width: AppLayout.shortest(context) * 0.2,
                    height: AppLayout.shortest(context) * 0.2,
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
        SizedBox(
          width: AppLayout.width(context) * 0.9,
          height: AppLayout.height(context) * 0.1,
          child: GridView.count(
            physics: const ScrollPhysics(),
            crossAxisCount: (AppLayout.width(context) * 0.01).toInt(),
            mainAxisSpacing: AppLayout.height(context) * 0.025,
            crossAxisSpacing: AppLayout.width(context) * 0.001,
            children: List.generate(user.player!.equipment.bag.length, (index) {
              return GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: AppLayout.shortest(context) * 0.005,
                  height: AppLayout.shortest(context) * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SvgPicture.asset(
                          user.player!.equipment.bag[index].icon,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
