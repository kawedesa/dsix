import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_text_dialog.dart';
import 'package:flutter/material.dart';

class AppAttributeSlider extends StatefulWidget {
  final String attributeTitle;
  final String attributeDescription;
  final Color color;
  final Color iconColor;
  final String icon;
  final int value;
  final Function() add;
  final Function() remove;
  const AppAttributeSlider({
    super.key,
    required this.attributeTitle,
    required this.attributeDescription,
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.value,
    required this.add,
    required this.remove,
  });

  @override
  State<AppAttributeSlider> createState() => _AppAttributeSliderState();
}

class _AppAttributeSliderState extends State<AppAttributeSlider> {
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
          width: MediaQuery.of(context).size.shortestSide * 0.5,
          height: MediaQuery.of(context).size.shortestSide * 0.05,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: MediaQuery.of(context).size.shortestSide * 0.01,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.shortestSide * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.color,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.color,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.color,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.color,
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                height:
                                    MediaQuery.of(context).size.shortestSide *
                                        0.01,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height:
                              MediaQuery.of(context).size.shortestSide * 0.005,
                          width: double.infinity,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(widget.value * 0.5 * 0.85, 0),
                child: AppCircularButton(
                  icon: widget.icon,
                  iconColor: widget.iconColor,
                  color: widget.color,
                  borderColor: widget.color,
                  size: 0.05,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppTextDialog(
                          title: widget.attributeTitle,
                          dialogText: widget.attributeDescription,
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
