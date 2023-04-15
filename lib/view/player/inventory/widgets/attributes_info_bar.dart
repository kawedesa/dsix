import 'package:dsix/model/combat/attribute/attribute.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class AttributesInfoBar extends StatelessWidget {
  final Color color;
  final Color darkColor;
  final Attribute attributes;

  const AttributesInfoBar(
      {super.key,
      required this.color,
      required this.darkColor,
      required this.attributes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppLayout.avarage(context) * 0.5,
      height: AppLayout.avarage(context) * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              AppCircularButton(
                  icon: AppImages.power,
                  iconColor: darkColor,
                  color: color,
                  borderColor: color,
                  size: 0.04),
              const AppSeparatorHorizontal(value: 0.015),
              AppText(
                  text: attributes.power.attribute.toString(),
                  fontSize: 0.015,
                  letterSpacing: 0.001,
                  color: Colors.white),
            ],
          ),
          Row(
            children: [
              AppCircularButton(
                  icon: AppImages.defense,
                  iconColor: darkColor,
                  color: color,
                  borderColor: color,
                  size: 0.04),
              const AppSeparatorHorizontal(value: 0.015),
              AppText(
                  text: attributes.defense.attribute.toString(),
                  fontSize: 0.015,
                  letterSpacing: 0.001,
                  color: Colors.white),
            ],
          ),
          Row(
            children: [
              AppCircularButton(
                  icon: AppImages.vision,
                  iconColor: darkColor,
                  color: color,
                  borderColor: color,
                  size: 0.04),
              const AppSeparatorHorizontal(value: 0.015),
              AppText(
                  text: attributes.vision.attribute.toString(),
                  fontSize: 0.015,
                  letterSpacing: 0.001,
                  color: Colors.white),
            ],
          ),
          Row(
            children: [
              AppCircularButton(
                  icon: AppImages.movement,
                  iconColor: darkColor,
                  color: color,
                  borderColor: color,
                  size: 0.04),
              const AppSeparatorHorizontal(value: 0.015),
              AppText(
                  text: attributes.movement.attribute.toString(),
                  fontSize: 0.015,
                  letterSpacing: 0.001,
                  color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
