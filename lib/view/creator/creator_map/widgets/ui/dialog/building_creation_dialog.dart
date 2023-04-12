import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/building/building_list.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BuildingCreationDialog extends StatefulWidget {
  const BuildingCreationDialog({
    super.key,
  });

  @override
  State<BuildingCreationDialog> createState() => _BuildingCreationDialogState();
}

class _BuildingCreationDialogState extends State<BuildingCreationDialog> {
  Building? selectedBuilding;
  int index = 0;

  void changeSelectedBuilding(int value) {
    index += value;

    if (index < 0) {
      index = BuildingList().getBuildingList().length - 1;
    }

    if (index > BuildingList().getBuildingList().length - 1) {
      index = 0;
    }
    selectBuilding();
  }

  void selectBuilding() {
    selectedBuilding = BuildingList().getBuildingList()[index];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    selectedBuilding ??= BuildingList().getBuildingList().first;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.6,
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
            const DialogTitle(
              color: AppColors.uiColor,
              title: 'buildings',
            ),
            Container(
              color: Colors.black,
              width: AppLayout.avarage(context) * 0.6,
              height: AppLayout.avarage(context) * 0.375,
              child: Padding(
                padding: EdgeInsets.all(AppLayout.avarage(context) * 0.025),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppCircularButton(
                        icon: AppImages.left,
                        iconColor: AppColors.uiColor,
                        color: Colors.transparent,
                        borderColor: AppColors.uiColor,
                        size: 0.075,
                        onTap: () {
                          setState(() {
                            changeSelectedBuilding(-1);
                          });
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppImages().getBuildingIcon(selectedBuilding!.name),
                        width: AppLayout.avarage(context) * 0.25,
                        height: AppLayout.avarage(context) * 0.25,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppCircularButton(
                        icon: AppImages.right,
                        iconColor: AppColors.uiColor,
                        color: Colors.transparent,
                        borderColor: AppColors.uiColor,
                        size: 0.075,
                        onTap: () {
                          setState(() {
                            changeSelectedBuilding(1);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DialogButton(
                color: AppColors.uiColor,
                buttonText: 'choose',
                onTap: () {
                  selectedBuilding!.id = DateTime.now().millisecondsSinceEpoch;
                  user.deselect();
                  user.selectBuilding(selectedBuilding!);
                  user.startPlacingBuilding();
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
