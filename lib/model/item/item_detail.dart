import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/item/item.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  final Item item;
  final Color color;
  final Color darkColor;

  const ItemDetail(
      {super.key,
      required this.item,
      required this.color,
      required this.darkColor});

  List<Widget> getItemDetail() {
    List<Widget> itemDetail = [];

    for (Attack attack in item.attacks) {
      itemDetail.add(
        AppCircularButton(
            icon: AppImages().getActionIcon(attack.name),
            iconSize: 0.9,
            iconColor: darkColor,
            color: color,
            borderColor: color,
            borderSize: 2,
            size: 0.04),
      );
      itemDetail.add(
        const AppSeparatorVertical(value: 0.0125),
      );
    }

    if (item.armor.pArmor != 0) {
      itemDetail.add(
        Row(
          children: [
            AppCircularButton(
                icon: AppImages.pArmor,
                iconColor: darkColor,
                color: color,
                borderColor: color,
                size: 0.025),
            const AppSeparatorHorizontal(value: 0.01),
            AppText(
                text: item.armor.pArmor.toString(),
                fontSize: 0.015,
                letterSpacing: 0.002,
                color: Colors.white),
          ],
        ),
      );
      itemDetail.add(
        const AppSeparatorVertical(value: 0.0125),
      );
    }
    if (item.armor.mArmor != 0) {
      itemDetail.add(Row(
        children: [
          AppCircularButton(
              icon: AppImages.mArmor,
              iconColor: darkColor,
              color: color,
              borderColor: color,
              size: 0.025),
          const AppSeparatorHorizontal(value: 0.01),
          AppText(
              text: item.armor.mArmor.toString(),
              fontSize: 0.015,
              letterSpacing: 0.002,
              color: Colors.white),
        ],
      ));
      itemDetail.add(
        const AppSeparatorVertical(value: 0.0125),
      );
    }

    itemDetail.add(Row(
      children: [
        AppCircularButton(
            icon: AppImages.weight,
            iconColor: darkColor,
            color: color,
            borderColor: color,
            size: 0.025),
        const AppSeparatorHorizontal(value: 0.01),
        AppText(
            text: item.weight.toString(),
            fontSize: 0.015,
            letterSpacing: 0.002,
            color: Colors.white),
      ],
    ));
    itemDetail.add(
      const AppSeparatorVertical(value: 0.0125),
    );
    itemDetail.add(Row(
      children: [
        AppCircularButton(
            icon: AppImages.money,
            iconColor: darkColor,
            color: color,
            borderColor: color,
            size: 0.025),
        const AppSeparatorHorizontal(value: 0.01),
        AppText(
            text: item.value.toString(),
            fontSize: 0.015,
            letterSpacing: 0.002,
            color: Colors.white),
      ],
    ));

    return itemDetail;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: getItemDetail());
  }
}
