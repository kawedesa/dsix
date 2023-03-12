import 'package:dsix/model/building/building.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlayerViewBuildingSprite extends StatefulWidget {
  final Building building;
  final bool selected;
  final Function() selectBuilding;
  final Function() deselect;

  const PlayerViewBuildingSprite({
    super.key,
    required this.building,
    required this.selected,
    required this.selectBuilding,
    required this.deselect,
  });

  @override
  State<PlayerViewBuildingSprite> createState() =>
      _PlayerViewBuildingSpriteState();
}

class _PlayerViewBuildingSpriteState extends State<PlayerViewBuildingSprite> {
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
    return Positioned(
      left: widget.building.position.dx - (widget.building.size / 2),
      top: widget.building.position.dy - (widget.building.size / 2),
      child: SizedBox(
        height: widget.building.size,
        width: widget.building.size,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  // if (widget.selected) {
                  //   widget.deselect();
                  // } else {
                  //   widget.selectBuilding();
                  // }

                  // refresh();
                },
                child: SvgPicture.asset(
                  AppImages().getBuildingIcon(widget.building.name),
                  height: widget.building.size,
                  width: widget.building.size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
