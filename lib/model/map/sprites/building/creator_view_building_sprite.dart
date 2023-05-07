import 'package:dsix/model/building/building.dart';
import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/model/map/buttons/map_circular_button.dart';
import 'package:dsix/shared/images/building_image.dart';
import 'package:dsix/shared/shared_widgets/button/app_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CreatorViewBuildingSprite extends StatefulWidget {
  final Building building;
  final Function() fullRefresh;
  const CreatorViewBuildingSprite({
    super.key,
    required this.building,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewBuildingSprite> createState() =>
      _CreatorViewBuildingSpriteState();
}

class _CreatorViewBuildingSpriteState extends State<CreatorViewBuildingSprite> {
  final BuildingSpriteController _controller = BuildingSpriteController();
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.building.position);
    _controller.checkSelected(user, widget.building);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left: _controller.tempPosition.newPosition.dx -
              (widget.building.size / 2),
          top: _controller.tempPosition.newPosition.dy -
              (widget.building.size / 2),
          child: SizedBox(
            height: widget.building.size,
            width: widget.building.size,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        if (_controller.selected) {
                          user.deselect();
                        } else {
                          user.deselect();
                          user.selectBuilding(widget.building);
                        }

                        widget.fullRefresh();
                      },
                      onPanStart: (details) {
                        if (_controller.isLocked == false) {
                          _controller.drag = true;
                        }
                        user.deselect();
                        user.selectBuilding(widget.building);
                        widget.fullRefresh();
                      },
                      onPanUpdate: (details) {
                        if (_controller.isLocked == false) {
                          _controller.tempPosition
                              .panUpdate(details.delta, false);
                          localRefresh();
                        }
                      },
                      onPanEnd: (details) {
                        if (_controller.isLocked == false) {
                          _controller.endMove(
                              _controller.tempPosition, widget.building);
                        }
                      },
                      child: BuildingImage(
                          name: widget.building.name,
                          isFlipped: widget.building.isFlipped,
                          size: widget.building.size)),
                ),
                _controller.getMenu(
                    widget.building, _controller.selected, localRefresh),
              ],
            ),
          ),
        ));
  }
}

class BuildingSpriteController {
  //SELECTION
  bool selected = false;
  void checkSelected(User user, Building building) {
    selected = user.checkSelectedBuilding(building.id);
  }

  //POSITION

  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Building building) {
    return Offset(tempPosition.newPosition.dx - building.size / 2,
        tempPosition.newPosition.dy - building.size / 2);
  }

  void endMove(TempPosition tempPosition, Building building) {
    building.changePosition(tempPosition.newPosition);
    drag = false;
  }

  //INTERNAL UI

  bool isLocked = false;

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
        icon: AppImages.locked,
        color: AppColors.uiColor.withAlpha(100),
        iconColor: AppColors.uiColorLight.withAlpha(200),
        borderColor: AppColors.uiColorLight.withAlpha(200),
        size: 4,
        onTap: () {
          unlockMenu();
          refresh();
        },
      );
    } else {
      menu = Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MapCircularButton(
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                icon: AppImages.minus,
                size: 3,
                onTap: () {
                  building.changeSize(-5);
                },
              ),
              const SizedBox(
                width: 2,
              ),
              MapCircularButton(
                icon: AppImages.unlocked,
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                size: 4,
                onTap: () {
                  lockMenu();
                  refresh();
                },
              ),
              const SizedBox(
                width: 2,
              ),
              MapCircularButton(
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                icon: AppImages.plus,
                size: 3,
                onTap: () {
                  building.changeSize(5);
                },
              ),
            ],
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  AppToggleButton(
                    color: AppColors.uiColorLight,
                    selected: building.alwaysVisible,
                    size: 2,
                    onTap: () {
                      building.changeAlwaysVisible();
                    },
                  ),
                  const SizedBox(width: 1),
                  SvgPicture.asset(AppImages.vision,
                      color: AppColors.uiColorLight, width: 2.5),
                ],
              ),
              const SizedBox(width: 2),
              Row(
                children: [
                  AppToggleButton(
                    color: AppColors.uiColorLight,
                    selected: building.isFlipped,
                    size: 2,
                    onTap: () {
                      building.flip();
                      refresh();
                    },
                  ),
                  const SizedBox(width: 1),
                  SvgPicture.asset(AppImages.horizontalFlip,
                      color: AppColors.uiColorLight, width: 2.5),
                ],
              )
            ],
          ),
        ],
      );
    }
    return SizedBox(
        width: building.size,
        height: building.size,
        child: Align(alignment: Alignment.bottomCenter, child: menu));
  }
}
