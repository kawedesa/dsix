import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/prop/prop_list.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/images/prop_image.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/button/app_text_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropCreationDialog extends StatefulWidget {
  const PropCreationDialog({
    super.key,
  });

  @override
  State<PropCreationDialog> createState() => _PropCreationDialogState();
}

class _PropCreationDialogState extends State<PropCreationDialog> {
  Prop? selectedProp;
  int lootValue = 500;
  void changeLootValue(int value) {
    lootValue += value;
    if (lootValue < 0) {
      lootValue = 0;
    }
  }

  int typeIndex = 0;
  List<String> typeList = [];

  void setTypeList() {
    switch (selectedProp!.name) {
      case 'chest':
        typeList = [
          'normal',
          'magic',
        ];
        break;
      case 'vase':
        typeList = [
          'blue',
          'brown',
          'orange',
          'pink',
          'yellow',
        ];
        break;
    }
  }

  void changeTypeIndex(int value) {
    typeIndex += value;

    if (typeIndex < 0) {
      typeIndex = typeList.length - 1;
    }

    if (typeIndex > typeList.length - 1) {
      typeIndex = 0;
    }
    selectedProp!.type = typeList[typeIndex];
    localRefresh();
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    selectedProp ??= PropList().getPropList().first;
    setTypeList();

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.uiColor,
          border: Border.all(
            color: AppColors.uiColor,
            width: AppLayout.avarage(context) * 0.0025,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppLayout.avarage(context) * 0.4,
              height: AppLayout.avarage(context) * 0.4,
              child: Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: AppLayout.avarage(context) * 0.4,
                        color: AppColors.uiColor,
                        child: ListView(
                          children: List.generate(
                              PropList().getPropList().length, (index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedProp =
                                          PropList().getPropList()[index];
                                    });
                                  },
                                  child: Container(
                                    color: (selectedProp!.name ==
                                            PropList()
                                                .getPropList()[index]
                                                .name)
                                        ? AppColors.uiColorLight
                                        : AppColors.uiColor,
                                    width: double.infinity,
                                    height: AppLayout.avarage(context) * 0.04,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          AppText(
                                            text: PropList()
                                                .getPropList()[index]
                                                .name
                                                .toUpperCase(),
                                            fontSize: 0.01,
                                            letterSpacing: 0.0002,
                                            color: (selectedProp!.name ==
                                                    PropList()
                                                        .getPropList()[index]
                                                        .name)
                                                ? AppColors.uiColor
                                                : Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const AppLineDividerHorizontal(
                                    color: Colors.black, value: 2),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.avarage(context) * 0.3,
                      height: AppLayout.avarage(context) * 0.4,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              bold: true,
                              text:
                                  '${selectedProp!.type} ${selectedProp!.name}'
                                      .toUpperCase(),
                              fontSize: 0.025,
                              letterSpacing: 0.002,
                              color: AppColors.uiColor),
                          SizedBox(
                            width: AppLayout.avarage(context) * 0.25,
                            height: AppLayout.avarage(context) * 0.25,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: PropImage(
                                    name: selectedProp!.name,
                                    type: selectedProp!.type,
                                    size: AppLayout.avarage(context) * 0.15,
                                    open: false,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: AppCircularButton(
                                      color: Colors.transparent,
                                      borderColor: AppColors.uiColor,
                                      iconColor: AppColors.uiColor,
                                      icon: AppImages.left,
                                      onTap: () {
                                        changeTypeIndex(-1);
                                      },
                                      size: 0.035),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: AppCircularButton(
                                      color: Colors.transparent,
                                      borderColor: AppColors.uiColor,
                                      iconColor: AppColors.uiColor,
                                      icon: AppImages.right,
                                      onTap: () {
                                        changeTypeIndex(1);
                                      },
                                      size: 0.035),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: AppLayout.avarage(context) * 0.125,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppCircularButton(
                                          icon: AppImages.minus,
                                          iconColor: AppColors.uiColor,
                                          color: Colors.transparent,
                                          borderColor: AppColors.uiColor,
                                          size: 0.025,
                                          onTap: () {
                                            changeLootValue(-100);
                                            localRefresh();
                                          },
                                        ),
                                        AppText(
                                          text: '\$$lootValue',
                                          fontSize: 0.02,
                                          letterSpacing: 0.0005,
                                          color: AppColors.uiColor,
                                        ),
                                        AppCircularButton(
                                          icon: AppImages.plus,
                                          iconColor: AppColors.uiColor,
                                          color: Colors.transparent,
                                          borderColor: AppColors.uiColor,
                                          size: 0.025,
                                          onTap: () {
                                            changeLootValue(100);
                                            localRefresh();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppTextButton(
                              color: AppColors.uiColor,
                              buttonText: 'choose',
                              onTap: () {
                                selectedProp!.setId();
                                selectedProp!.resetPosition();
                                selectedProp!.createLoot(lootValue);
                                user.startPlacingSomething('prop');
                                user.deselect();
                                user.selectProp(selectedProp!);
                                Navigator.pop(context);
                              }),
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
