import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/text_dialog.dart';
import 'package:flutter/material.dart';

class AppSlider extends StatefulWidget {
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

  @override
  State<AppSlider> createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  List<Widget> sliderDivision(int range) {
    List<Widget> tempList = [];

    while (tempList.length < range) {
      tempList.add(
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
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
          iconColor: widget.color,
          color: Colors.transparent,
          borderColor: widget.color,
          size: 0.1,
          onTap: () => widget.remove(),
        ),
        SizedBox(
          width: widget.width,
          height: widget.height,
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
                          width: widget.width - widget.height * 0.5,
                          height: AppLayout.shortest(context) * 0.008,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: sliderDivision(widget.range),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: AppLayout.shortest(context) * 0.005,
                          width: double.infinity,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment((widget.value / widget.range) * 2.25, 0),
                child: AppCircularButton(
                  icon: widget.icon,
                  iconColor: widget.iconColor,
                  color: widget.color,
                  borderColor: widget.color,
                  size: 0.09,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return TextDialog(
                          title: widget.sliderTitle,
                          dialogText: widget.sliderDescription,
                          color: widget.color,
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
          iconColor: widget.color,
          color: Colors.transparent,
          borderColor: widget.color,
          size: 0.1,
          onTap: () => widget.add(),
        ),
      ],
    );
  }
}
