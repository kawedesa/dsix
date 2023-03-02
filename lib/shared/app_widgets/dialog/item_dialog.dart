import 'package:dsix/model/item/item.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app_images.dart';
import '../button/app_circular_button.dart';
import '../layout/app_separator_horizontal.dart';
import '../layout/app_separator_vertical.dart';
import '../text/app_text.dart';

class ItemDialog extends StatefulWidget {
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
  State<ItemDialog> createState() => _ItemDialogState();
}

class _ItemDialogState extends State<ItemDialog> {
  List<Widget> getItemAttributes() {
    List<Widget> itemAttributes = [];

    if (widget.item.armor.pArmor != 0) {
      itemAttributes.add(
        Row(
          children: [
            AppCircularButton(
                icon: AppImages.pArmor,
                iconColor: widget.darkColor,
                color: widget.color,
                borderColor: widget.color,
                size: 0.05),
            const AppSeparatorHorizontal(value: 0.015),
            AppText(
                text: widget.item.armor.pArmor.toString(),
                fontSize: 0.02,
                letterSpacing: 0.002,
                color: Colors.white),
          ],
        ),
      );
      itemAttributes.add(
        const AppSeparatorVertical(value: 0.015),
      );
    }
    if (widget.item.armor.mArmor != 0) {
      itemAttributes.add(Row(
        children: [
          AppCircularButton(
              icon: AppImages.mArmor,
              iconColor: widget.darkColor,
              color: widget.color,
              borderColor: widget.color,
              size: 0.05),
          const AppSeparatorHorizontal(value: 0.015),
          AppText(
              text: widget.item.armor.mArmor.toString(),
              fontSize: 0.02,
              letterSpacing: 0.002,
              color: Colors.white),
        ],
      ));
      itemAttributes.add(
        const AppSeparatorVertical(value: 0.015),
      );
    }
    if (widget.item.attack.damage.pDamage != 0) {
      itemAttributes.add(Row(
        children: [
          AppCircularButton(
              icon: AppImages.pDamage,
              iconColor: widget.darkColor,
              color: widget.color,
              borderColor: widget.color,
              size: 0.05),
          const AppSeparatorHorizontal(value: 0.015),
          AppText(
              text: widget.item.attack.damage.pDamage.toString(),
              fontSize: 0.02,
              letterSpacing: 0.002,
              color: Colors.white),
        ],
      ));
      itemAttributes.add(
        const AppSeparatorVertical(value: 0.015),
      );
    }
    if (widget.item.attack.damage.mDamage != 0) {
      itemAttributes.add(Row(
        children: [
          AppCircularButton(
              icon: AppImages.mDamage,
              iconColor: widget.darkColor,
              color: widget.color,
              borderColor: widget.color,
              size: 0.05),
          const AppSeparatorHorizontal(value: 0.015),
          AppText(
              text: widget.item.attack.damage.mDamage.toString(),
              fontSize: 0.02,
              letterSpacing: 0.002,
              color: Colors.white),
        ],
      ));
      itemAttributes.add(
        const AppSeparatorVertical(value: 0.015),
      );
    }
    itemAttributes.add(Row(
      children: [
        AppCircularButton(
            icon: AppImages.weight,
            iconColor: widget.darkColor,
            color: widget.color,
            borderColor: widget.color,
            size: 0.05),
        const AppSeparatorHorizontal(value: 0.015),
        AppText(
            text: widget.item.weight.toString(),
            fontSize: 0.02,
            letterSpacing: 0.002,
            color: Colors.white),
      ],
    ));
    itemAttributes.add(
      const AppSeparatorVertical(value: 0.015),
    );
    itemAttributes.add(Row(
      children: [
        AppCircularButton(
            icon: AppImages.money,
            iconColor: widget.darkColor,
            color: widget.color,
            borderColor: widget.color,
            size: 0.05),
        const AppSeparatorHorizontal(value: 0.015),
        AppText(
            text: widget.item.value.toString(),
            fontSize: 0.02,
            letterSpacing: 0.002,
            color: Colors.white),
      ],
    ));

    return itemAttributes;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.5,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.color,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: widget.color,
              title: widget.item.name,
              subTitle: widget.item.itemSlot,
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppSeparatorVertical(value: 0.03),
                  Stack(
                    children: [
                      Align(
                        alignment: const Alignment(0.5, 0),
                        child: SvgPicture.asset(
                          AppImages().getItemIcon(widget.item.name),
                          width: AppLayout.shortest(context) * 0.3,
                          height: AppLayout.shortest(context) * 0.3,
                          color: Colors.white,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(-0.9, 0.0),
                        child: SizedBox(
                          width: AppLayout.shortest(context) * 0.2,
                          height: AppLayout.shortest(context) * 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: getItemAttributes(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const AppSeparatorVertical(value: 0.02),
                  DialogButton(
                      color: widget.color,
                      buttonText: 'sell',
                      onTap: () {
                        widget.sellItem();
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
