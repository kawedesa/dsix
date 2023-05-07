import 'dart:math';

import 'package:dsix/model/combat/position.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/model/combat/temp_position.dart';
import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/model/map/buttons/map_circular_button.dart';
import 'package:dsix/shared/images/tile_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class CreatorViewTileSprite extends StatefulWidget {
  final Tile tile;
  final Function() fullRefresh;
  const CreatorViewTileSprite({
    super.key,
    required this.tile,
    required this.fullRefresh,
  });

  @override
  State<CreatorViewTileSprite> createState() => _CreatorViewTileSpriteState();
}

class _CreatorViewTileSpriteState extends State<CreatorViewTileSprite> {
  final TileSpriteController _controller = TileSpriteController();
  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _controller.initializeTempPosition(widget.tile.position);
    _controller.checkSelected(user, widget.tile);

    return ChangeNotifierProxyProvider<Spawner, TempPosition>(
        create: (context) => _controller.tempPosition,
        update: (context, _, tempPosition) => tempPosition!..panEnd(),
        child: Positioned(
          left:
              _controller.tempPosition.newPosition.dx - (widget.tile.size / 2),
          top: _controller.tempPosition.newPosition.dy - (widget.tile.size / 2),
          child: SizedBox(
            height: widget.tile.size,
            width: widget.tile.size,
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
                          user.selectTile(widget.tile);
                        }

                        widget.fullRefresh();
                      },
                      onPanStart: (details) {
                        if (_controller.isLocked == false) {
                          _controller.drag = true;
                        }
                        user.deselect();
                        user.selectTile(widget.tile);
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
                              _controller.tempPosition, widget.tile);
                        }
                      },
                      child: TransparentPointer(
                        transparent: _controller.isLocked,
                        child: Opacity(
                          opacity: (widget.tile.visibility) ? 1.0 : 0.5,
                          child: TileImage(
                              name: widget.tile.name,
                              verticalFlip: widget.tile.verticalFlip,
                              horizontalFlip: widget.tile.horizontalFlip,
                              rotation: widget.tile.rotation,
                              size: widget.tile.size),
                        ),
                      )),
                ),
                _controller.getMenu(
                    user, widget.tile, _controller.selected, localRefresh),
              ],
            ),
          ),
        ));
  }
}

class TileSpriteController {
  //SELECTION
  bool selected = false;
  void checkSelected(User user, Tile tile) {
    selected = user.checkSelectedTile(tile.id);
  }

  //POSITION
  final TempPosition tempPosition = TempPosition();
  bool drag = false;

  void initializeTempPosition(Position originalPosition) {
    if (drag == false) {
      tempPosition.initialize(originalPosition);
    }
  }

  Offset getPosition(TempPosition tempPosition, Tile tile) {
    return Offset(tempPosition.newPosition.dx - tile.size / 2,
        tempPosition.newPosition.dy - tile.size / 2);
  }

  void endMove(TempPosition tempPosition, Tile tile) {
    tile.changePosition(tempPosition.newPosition);
    drag = false;
  }

  //INTERNAL UI
  bool isLocked = true;

  void lockMenu() {
    isLocked = true;
  }

  void unlockMenu() {
    isLocked = false;
  }

  Widget getMenu(User user, Tile tile, bool selected, Function refresh) {
    Widget menu = const SizedBox();

    if (isLocked) {
      menu = Align(
        alignment: Alignment.center,
        child: MapCircularButton(
          icon: AppImages.locked,
          color: AppColors.uiColor.withAlpha(100),
          iconColor: AppColors.uiColorLight.withAlpha(200),
          borderColor: AppColors.uiColorLight.withAlpha(200),
          size: 4,
          onTap: () {
            unlockMenu();
            refresh();
          },
        ),
      );
    } else {
      menu = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MapCircularButton(
                icon: AppImages.rotationLeft,
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                size: 4,
                onTap: () {
                  tile.changeRotation(-pi / 4);
                  refresh();
                },
              ),
              const SizedBox(
                width: 2,
              ),
              MapCircularButton(
                icon: AppImages.top,
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                size: 4,
                onTap: () {
                  user.putTileOnTop();
                  refresh();
                },
              ),
              const SizedBox(
                width: 2,
              ),
              MapCircularButton(
                icon: AppImages.rotationRight,
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                size: 4,
                onTap: () {
                  tile.changeRotation(pi / 4);
                  refresh();
                },
              ),
            ],
          ),
          const SizedBox(height: 1),
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
                  tile.changeSize(-10);
                  refresh();
                },
              ),
              const SizedBox(
                width: 2.5,
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
                width: 2.5,
              ),
              MapCircularButton(
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                icon: AppImages.plus,
                size: 3,
                onTap: () {
                  tile.changeSize(10);
                  refresh();
                },
              ),
            ],
          ),
          const SizedBox(height: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MapCircularButton(
                color: AppColors.uiColor.withAlpha(200),
                iconColor: AppColors.uiColorLight.withAlpha(200),
                borderColor: AppColors.uiColorLight.withAlpha(200),
                icon: AppImages.horizontalFlip,
                size: 4,
                onTap: () {
                  tile.flipHorizontal();
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
                icon: AppImages.vision,
                size: 4,
                onTap: () {
                  tile.changeVisibility();
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
                icon: AppImages.verticalFlip,
                size: 4,
                onTap: () {
                  tile.flipVertical();
                  refresh();
                },
              ),
            ],
          )
        ],
      );
    }
    return SizedBox(width: tile.size, height: tile.size, child: menu);
  }
}
