import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/dialog/text_dialog.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatelessWidget {
  final double height;
  final double width;
  final int range;
  final String sliderTitle;
  final String sliderDescription;
  final Color color;
  final Color iconColor;
  final String icon;
  final int value;
  final Function() add;
  final Function() remove;
  const AppSlider({
    super.key,
    required this.height,
    required this.width,
    required this.range,
    required this.sliderTitle,
    required this.sliderDescription,
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.value,
    required this.add,
    required this.remove,
  });

  List<Widget> sliderDivision(int range) {
    List<Widget> tempList = [];

    while (tempList.length < range) {
      tempList.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
      );
    }

    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppCircularButton(
          icon: AppImages.minus,
          iconColor: color,
          color: Colors.transparent,
          borderColor: color,
          size: 0.075,
          onTap: () => remove(),
        ),
        SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: AppLayout.shortest(context) * 0.01,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: width - height * 0.5,
                          height: AppLayout.avarage(context) * 0.004,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: sliderDivision(range),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: AppLayout.avarage(context) * 0.002,
                          width: double.infinity,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment((value / range) * 2.25, 0),
                child: AppCircularButton(
                  icon: icon,
                  iconColor: iconColor,
                  color: color,
                  borderColor: color,
                  size: 0.04,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TextDialog(
                          title: sliderTitle,
                          dialogText: sliderDescription,
                          color: color,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        AppCircularButton(
          icon: AppImages.plus,
          iconColor: color,
          color: Colors.transparent,
          borderColor: color,
          size: 0.075,
          onTap: () => add(),
        ),
      ],
    );
  }
}
