import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/map/map_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorViewBuildingSprite extends StatefulWidget {
  final Building building;
  final bool selected;
  final Function() selectBuilding;
  final Function() deselect;

  const CreatorViewBuildingSprite({
    super.key,
    required this.building,
    required this.selected,
    required this.selectBuilding,
    required this.deselect,
  });

  @override
  State<CreatorViewBuildingSprite> createState() =>
      _CreatorViewBuildingSpriteState();
}

class _CreatorViewBuildingSpriteState extends State<CreatorViewBuildingSprite> {
  final BuildingSpriteController _controller = BuildingSpriteController();
  final TempPosition _tempPosition = TempPosition();
  bool drag = false;

  Color getColor() {
    if (widget.selected) {
      return AppColors.uiColorLight.withAlpha(75);
    } else {
      return AppColors.uiColorDark.withAlpha(25);
    }
  }

  Color getStrokeColor() {
    if (widget.selected) {
      return AppColors.uiColorLight.withAlpha(200);
    } else {
      return AppColors.uiColorDark.withAlpha(100);
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (drag == false) {
      _tempPosition.initialize(widget.building.position);
    }

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _tempPosition.newPosition.dx - (widget.building.size / 2),
          top: _tempPosition.newPosition.dy - (widget.building.size / 2),
          child: SizedBox(
            height: widget.building.size,
            width: widget.building.size,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selected) {
                        widget.deselect();
                      } else {
                        widget.selectBuilding();
                      }

                      refresh();
                    },
                    onPanStart: (details) {
                      if (_controller.isLocked == false) {
                        drag = true;
                      }

                      widget.selectBuilding();
                    },
                    onPanUpdate: (details) {
                      if (_controller.isLocked == false) {
                        _tempPosition.panUpdate(details.delta, 'tile');
                      }

                      refresh();
                    },
                    onPanEnd: (details) {
                      if (_controller.isLocked == false) {
                        _controller.endMove(_tempPosition, widget.building);
                        drag = false;
                      }

                      refresh();
                    },
                    child: SvgPicture.asset(
                      AppImages().getBuildingIcon(widget.building.name),
                      height: widget.building.size,
                      width: widget.building.size,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: _controller.getMenu(
                        widget.building, widget.selected, refresh)),
              ],
            ),
          ),
        ));
  }
}

class BuildingSpriteController {
  Offset getPosition(TempPosition tempPosition, Building building) {
    return Offset(tempPosition.newPosition.dx - building.size / 2,
        tempPosition.newPosition.dy - building.size / 2);
  }

  void endMove(TempPosition tempPosition, Building building) {
    building.changePosition(tempPosition.newPosition);
  }

  bool isLocked = true;

  void lockMenu() {
    isLocked = true;
  }

  void unlockMenu() {
    isLocked = false;
  }

  Widget getMenu(Building building, bool selected, Function refresh) {
    if (selected == false) {
      return const SizedBox();
    }

    Widget menu = const SizedBox();

    if (isLocked) {
      menu = MapCircularButton(
        color: AppColors.uiColor.withAlpha(100),
        iconColor: AppColors.uiColorLight.withAlpha(200),
        borderColor: AppColors.uiColorLight.withAlpha(200),
        size: 6.0,
        onTap: () {
          unlockMenu();
          refresh();
        },
      );
    } else {
      menu = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MapCircularButton(
            color: AppColors.uiColor.withAlpha(200),
            iconColor: AppColors.uiColorLight.withAlpha(200),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            icon: AppImages.minus,
            size: 6.0,
            onTap: () {
              building.changeSize(-5);
            },
          ),
          MapCircularButton(
            color: AppColors.uiColor.withAlpha(200),
            iconColor: AppColors.uiColorLight.withAlpha(200),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            size: 6.0,
            onTap: () {
              lockMenu();
              refresh();
            },
          ),
          MapCircularButton(
            color: AppColors.uiColor.withAlpha(200),
            iconColor: AppColors.uiColorLight.withAlpha(200),
            borderColor: AppColors.uiColorLight.withAlpha(200),
            icon: AppImages.plus,
            size: 6.0,
            onTap: () {
              building.changeSize(5);
            },
          ),
        ],
      );
    }
    return menu;
  }
}
