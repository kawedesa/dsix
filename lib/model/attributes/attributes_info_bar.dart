import 'package:dsix/model/attributes/attributes.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';

class AttributesInfoBar extends StatelessWidget {
  final double size;
  final Color color;
  final Color darkColor;
  final Attributes attributes;

  const AttributesInfoBar(
      {super.key,
      required this.size,
      required this.color,
      required this.darkColor,
      required this.attributes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppLayout.avarage(context) * size,
      height: AppLayout.avarage(context) * size * 0.1,
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
                  size: size * 0.1),
              AppSeparatorHorizontal(value: size * 0.03),
              AppText(
                  text: attributes.power.attribute.toString(),
                  fontSize: size * 0.04,
                  letterSpacing: size * 0.001,
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
                  size: size * 0.1),
              AppSeparatorHorizontal(value: size * 0.03),
              AppText(
                  text: attributes.defense.attribute.toString(),
                  fontSize: size * 0.04,
                  letterSpacing: size * 0.001,
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
                  size: size * 0.1),
              AppSeparatorHorizontal(value: size * 0.03),
              AppText(
                  text: attributes.vision.attribute.toString(),
                  fontSize: size * 0.04,
                  letterSpacing: size * 0.001,
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
                  size: size * 0.1),
              AppSeparatorHorizontal(value: size * 0.03),
              AppText(
                  text: attributes.movement.attribute.toString(),
                  fontSize: size * 0.04,
                  letterSpacing: size * 0.001,
                  color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
