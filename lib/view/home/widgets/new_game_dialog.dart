import 'package:dsix/model/game/game.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_slider.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/button/app_toggle_button.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import '../../../shared/images/app_images.dart';
import '../../../shared/shared_widgets/layout/app_separator_vertical.dart';

class NewGameDialog extends StatefulWidget {
  final Game game;
  const NewGameDialog({
    required this.game,
    super.key,
  });

  @override
  State<NewGameDialog> createState() => _NewGameDialogState();
}

class _NewGameDialogState extends State<NewGameDialog> {
  int numberOfPlayers = 3;

  void changeNumberOfPlayers(int value) {
    numberOfPlayers += value;
    if (numberOfPlayers < 1) {
      numberOfPlayers = 1;
    }
    if (numberOfPlayers > 5) {
      numberOfPlayers = 5;
    }
  }

  int startingAmountOfGold = 500;

  void changeStartingAmountOfGold(int value) {
    startingAmountOfGold += value;
    if (startingAmountOfGold < 500) {
      startingAmountOfGold = 500;
    }
    if (startingAmountOfGold > 2000) {
      startingAmountOfGold = 2000;
    }
  }

  bool sharedTeamVision = true;

  void changeSharedTeamVision() {
    if (sharedTeamVision) {
      sharedTeamVision = false;
    } else {
      sharedTeamVision = true;
    }
  }

  void localRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.4,
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
              title: 'new game?',
            ),
            Container(
              color: Colors.black,
              width: AppLayout.avarage(context) * 0.4,
              child: Padding(
                padding: EdgeInsets.all(AppLayout.avarage(context) * 0.015),
                child: Column(
                  children: [
                    const AppSeparatorVertical(value: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'NUMBER OF PLAYERS',
                          fontSize: 0.01,
                          letterSpacing: 0.002,
                          color: AppColors.uiColor,
                        ),
                        SizedBox(
                          width: AppLayout.avarage(context) * 0.125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCircularButton(
                                icon: AppImages.minus,
                                iconColor: AppColors.uiColor,
                                color: Colors.transparent,
                                borderColor: AppColors.uiColor,
                                size: 0.025,
                                onTap: () {
                                  changeNumberOfPlayers(-1);
                                  localRefresh();
                                },
                              ),
                              AppText(
                                text: numberOfPlayers.toString(),
                                fontSize: 0.02,
                                letterSpacing: 0.01,
                                color: AppColors.uiColor,
                              ),
                              AppCircularButton(
                                icon: AppImages.plus,
                                iconColor: AppColors.uiColor,
                                color: Colors.transparent,
                                borderColor: AppColors.uiColor,
                                size: 0.025,
                                onTap: () {
                                  changeNumberOfPlayers(1);
                                  localRefresh();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const AppSeparatorVertical(value: 0.02),
                    const AppLineDividerHorizontal(
                        color: AppColors.uiColor, value: 1),
                    const AppSeparatorVertical(value: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'STARTING AMOUNT OF GOLD',
                          fontSize: 0.01,
                          letterSpacing: 0.002,
                          color: AppColors.uiColor,
                        ),
                        SizedBox(
                          width: AppLayout.avarage(context) * 0.125,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCircularButton(
                                icon: AppImages.minus,
                                iconColor: AppColors.uiColor,
                                color: Colors.transparent,
                                borderColor: AppColors.uiColor,
                                size: 0.025,
                                onTap: () {
                                  changeStartingAmountOfGold(-100);
                                  localRefresh();
                                },
                              ),
                              AppText(
                                text: '\$${startingAmountOfGold.toString()}',
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
                                  changeStartingAmountOfGold(100);
                                  localRefresh();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const AppSeparatorVertical(value: 0.02),
                    const AppLineDividerHorizontal(
                        color: AppColors.uiColor, value: 1),
                    const AppSeparatorVertical(value: 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const AppText(
                          text: 'SHARED TEAM VISION',
                          fontSize: 0.01,
                          letterSpacing: 0.002,
                          color: AppColors.uiColor,
                        ),
                        SizedBox(
                          width: AppLayout.avarage(context) * 0.125,
                          child: Center(
                              child: AppToggleButton(
                            color: AppColors.uiColor,
                            selected: sharedTeamVision,
                            size: 0.025,
                            onTap: () {
                              changeSharedTeamVision();
                              localRefresh();
                            },
                          )),
                        ),
                      ],
                    ),
                    const AppSeparatorVertical(value: 0.03),
                  ],
                ),
              ),
            ),
            DialogButton(
                color: AppColors.uiColor,
                buttonText: 'confirm',
                onTap: () {
                  widget.game.newGame(
                      numberOfPlayers, startingAmountOfGold, sharedTeamVision);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
