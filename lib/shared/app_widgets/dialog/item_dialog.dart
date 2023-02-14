import 'package:dsix/model/item/item.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_images.dart';
import '../button/app_circular_button.dart';
import '../layout/app_separator_horizontal.dart';
import '../layout/app_separator_vertical.dart';
import '../text/app_text.dart';

class ItemDialog extends StatelessWidget {
  final Color color;
  final Color darkColor;
  final Item item;
  final Function() sellItem;
  const ItemDialog({
    super.key,
    required this.color,
    required this.darkColor,
    required this.item,
    required this.sellItem,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.6,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: color,
              title: item.name,
              subTitle: item.itemSlot,
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppSeparatorVertical(value: 0.05),
                  Stack(
                    children: [
                      SvgPicture.asset(
                        AppImages().getItemIcon(item.name),
                        width: AppLayout.shortest(context) * 0.4,
                        height: AppLayout.shortest(context) * 0.4,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const AppSeparatorVertical(value: 0.05),
                  AppLineDividerHorizontal(
                    color: color,
                    value: 2,
                  ),
                  Column(
                    children: [
                      const AppSeparatorVertical(value: 0.01),
                      (item.description != '')
                          ? SizedBox(
                              width: AppLayout.shortest(context) * 0.8,
                              child: AppText(
                                text: item.description,
                                fontSize: 0.025,
                                letterSpacing: 0.004,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(
                              width: AppLayout.shortest(context) * 0.8,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const AppSeparatorHorizontal(value: 0.01),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.pDamage,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.pDamage.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                      const AppSeparatorVertical(value: 0.01),
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.mDamage,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.mDamage.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.pArmor,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.pArmor.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                      const AppSeparatorVertical(value: 0.01),
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.mArmor,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.mArmor.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.maxRange,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.maxRange.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                      const AppSeparatorVertical(value: 0.01),
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.minRange,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.minRange.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.weight,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.weight.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                      const AppSeparatorVertical(value: 0.01),
                                      Row(
                                        children: [
                                          AppCircularButton(
                                              icon: AppImages.money,
                                              iconColor: darkColor,
                                              color: color,
                                              borderColor: color,
                                              size: 0.055),
                                          const AppSeparatorHorizontal(
                                              value: 0.01),
                                          AppText(
                                              text: item.value.toString(),
                                              fontSize: 0.03,
                                              letterSpacing: 0.0015,
                                              color: Colors.white),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const AppSeparatorHorizontal(value: 0.01),
                                ],
                              ),
                            ),
                      const AppSeparatorVertical(value: 0.01),
                    ],
                  ),
                  DialogButton(
                      color: color,
                      buttonText: 'sell',
                      onTap: () {
                        sellItem();
                        Navigator.pop(context);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
