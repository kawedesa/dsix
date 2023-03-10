import 'package:dsix/model/building/building.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/view/creator/creator_map/widgets/ui/building_creation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildingCreationButton extends StatefulWidget {
  final bool active;
  final Function(Building) startPlacingBuilding;
  const BuildingCreationButton(
      {super.key, required this.active, required this.startPlacingBuilding});

  @override
  State<BuildingCreationButton> createState() => _BuildingCreationButtonState();
}

class _BuildingCreationButtonState extends State<BuildingCreationButton> {
  void createBuilding(Building selectedBuilding, List<Building> buildings) {
    int newBuildingId = DateTime.now().millisecondsSinceEpoch;

    Building newBuilding = selectedBuilding;
    newBuilding.id = newBuildingId;

    widget.startPlacingBuilding(newBuilding);
  }

  @override
  Widget build(BuildContext context) {
    final buildings = Provider.of<List<Building>>(context);

    return (widget.active)
        ? AppCircularButton(
            onTap: () {
              setState(
                () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return BuildingCreationDialog(
                          chooseBuilding: (building) {
                            createBuilding(building, buildings);
                          },
                        );
                      });
                },
              );
            },
            icon: AppImages.building,
            iconColor: AppColors.uiColorLight.withAlpha(200),
            color: AppColors.uiColor.withAlpha(100),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 0.04)
        : AppCircularButton(
            icon: AppImages.building,
            iconColor: AppColors.uiColor.withAlpha(200),
            color: AppColors.uiColorDark.withAlpha(100),
            borderColor: AppColors.uiColorDark.withAlpha(200),
            size: 0.04);
  }
}
