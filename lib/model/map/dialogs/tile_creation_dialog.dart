import 'package:dsix/model/tile/tile.dart';
import 'package:dsix/model/tile/tile_list.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/images/tile_image.dart';
import 'package:dsix/shared/shared_widgets/button/app_text_button.dart';
import 'package:dsix/shared/shared_widgets/button/app_toggle_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TileCreationDialog extends StatefulWidget {
  const TileCreationDialog({
    super.key,
  });

  @override
  State<TileCreationDialog> createState() => _TileCreationDialogState();
}

class _TileCreationDialogState extends State<TileCreationDialog> {
  Tile? selectedTile;

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    selectedTile ??= TileList().getTileList().first;

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
                        width: AppLayout.avarage(context) * 0.05,
                        color: Colors.black,
                        child: ListView(
                          children: List.generate(
                              TileList().getTileList().length, (index) {
                            return Column(
                              children: [
                                const AppLineDividerHorizontal(
                                    color: Colors.black, value: 1),
                                GestureDetector(
                                  onTap: () {
                                    selectedTile =
                                        TileList().getTileList()[index];
                                    localRefresh();
                                  },
                                  child: Container(
                                    color: (selectedTile!.name ==
                                            TileList()
                                                .getTileList()[index]
                                                .name)
                                        ? AppColors.uiColorLight
                                        : AppColors.uiColor,
                                    width: AppLayout.avarage(context) * 0.05,
                                    height: AppLayout.avarage(context) * 0.05,
                                    child: Center(
                                      child: TileImage(
                                          name: TileList()
                                              .getTileList()[index]
                                              .name,
                                          verticalFlip: false,
                                          horizontalFlip: false,
                                          rotation: 0,
                                          size: AppLayout.avarage(context) *
                                              0.035),
                                    ),
                                  ),
                                ),
                                const AppLineDividerHorizontal(
                                    color: Colors.black, value: 1),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.avarage(context) * 0.35,
                      height: AppLayout.avarage(context) * 0.4,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const AppSeparatorVertical(value: 0.01),
                          AppText(
                              bold: true,
                              text: selectedTile!.name.toUpperCase(),
                              fontSize: 0.025,
                              letterSpacing: 0.002,
                              color: AppColors.uiColor),
                          SizedBox(
                            width: AppLayout.avarage(context) * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    AppToggleButton(
                                      color: AppColors.uiColor,
                                      selected: selectedTile!.verticalFlip,
                                      size: AppLayout.avarage(context) * 0.01,
                                      onTap: () {
                                        selectedTile!.flipVertical();
                                        localRefresh();
                                      },
                                    ),
                                    const AppSeparatorHorizontal(value: 0.005),
                                    SvgPicture.asset(AppImages.verticalFlip,
                                        color: AppColors.uiColor,
                                        width:
                                            AppLayout.avarage(context) * 0.015),
                                  ],
                                ),
                                const AppSeparatorHorizontal(value: 0.1),
                                Row(
                                  children: [
                                    AppToggleButton(
                                      color: AppColors.uiColor,
                                      selected: selectedTile!.visibility,
                                      size: AppLayout.avarage(context) * 0.01,
                                      onTap: () {
                                        selectedTile!.changeVisibility();
                                        localRefresh();
                                      },
                                    ),
                                    const AppSeparatorHorizontal(value: 0.005),
                                    SvgPicture.asset(AppImages.vision,
                                        color: AppColors.uiColor,
                                        width:
                                            AppLayout.avarage(context) * 0.015),
                                  ],
                                ),
                                const AppSeparatorHorizontal(value: 0.1),
                                Row(
                                  children: [
                                    AppToggleButton(
                                      color: AppColors.uiColor,
                                      selected: selectedTile!.horizontalFlip,
                                      size: AppLayout.avarage(context) * 0.01,
                                      onTap: () {
                                        selectedTile!.flipHorizontal();
                                        localRefresh();
                                      },
                                    ),
                                    const AppSeparatorHorizontal(value: 0.005),
                                    SvgPicture.asset(AppImages.horizontalFlip,
                                        color: AppColors.uiColor,
                                        width:
                                            AppLayout.avarage(context) * 0.015),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const AppSeparatorVertical(value: 0.035),
                          TileImage(
                            name: selectedTile!.name,
                            verticalFlip: selectedTile!.verticalFlip,
                            horizontalFlip: selectedTile!.horizontalFlip,
                            rotation: selectedTile!.rotation,
                            size: AppLayout.avarage(context) * 0.2,
                          ),
                          const AppSeparatorVertical(value: 0.03),
                          AppTextButton(
                              color: AppColors.uiColor,
                              buttonText: 'choose',
                              onTap: () {
                                selectedTile!.setId();
                                selectedTile!.resetPosition();
                                user.startPlacingSomething('tile');
                                user.deselect();
                                user.selectTile(selectedTile!);
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
