import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/chest/chest_list.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/images/chest_image.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/button/app_text_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChestCreationDialog extends StatefulWidget {
  const ChestCreationDialog({
    super.key,
  });

  @override
  State<ChestCreationDialog> createState() => _ChestCreationDialogState();
}

class _ChestCreationDialogState extends State<ChestCreationDialog> {
  Chest? selectedChest;
  int lootValue = 500;
  void changeLootValue(int value) {
    lootValue += value;
    if (lootValue < 0) {
      lootValue = 0;
    }
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    selectedChest ??= ChestList().getChestList().first;

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
                              ChestList().getChestList().length, (index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedChest =
                                          ChestList().getChestList()[index];
                                    });
                                  },
                                  child: Container(
                                    color: (selectedChest!.name ==
                                            ChestList()
                                                .getChestList()[index]
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
                                            text: ChestList()
                                                .getChestList()[index]
                                                .name
                                                .toUpperCase(),
                                            fontSize: 0.01,
                                            letterSpacing: 0.0002,
                                            color: (selectedChest!.name ==
                                                    ChestList()
                                                        .getChestList()[index]
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
                              text: selectedChest!.name.toUpperCase(),
                              fontSize: 0.025,
                              letterSpacing: 0.002,
                              color: AppColors.uiColor),
                          ChestImage(
                            name: selectedChest!.name,
                            size: AppLayout.avarage(context) * 0.1,
                            open: false,
                          ),
                          SizedBox(
                            width: AppLayout.avarage(context) * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppCircularButton(
                                    onTap: () {
                                      changeLootValue(-100);
                                      localRefresh();
                                    },
                                    icon: AppImages.minus,
                                    iconColor: AppColors.uiColor,
                                    color: Colors.transparent,
                                    borderColor: AppColors.uiColor,
                                    size: 0.03),
                                AppText(
                                    text: '\$$lootValue',
                                    fontSize: 0.025,
                                    letterSpacing: 0.001,
                                    color: AppColors.uiColor),
                                AppCircularButton(
                                    onTap: () {
                                      changeLootValue(100);
                                      localRefresh();
                                    },
                                    icon: AppImages.plus,
                                    iconColor: AppColors.uiColor,
                                    color: Colors.transparent,
                                    borderColor: AppColors.uiColor,
                                    size: 0.03)
                              ],
                            ),
                          ),
                          AppTextButton(
                              color: AppColors.uiColor,
                              buttonText: 'choose',
                              onTap: () {
                                selectedChest!.setId();
                                selectedChest!.createLoot(lootValue);
                                user.deselect();
                                user.selectChest(selectedChest!);
                                user.startPlacingSomething('chest');
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
