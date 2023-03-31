import 'package:dsix/model/game/game.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_slider.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/dialog_title.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:flutter/material.dart';
import '../../app_images.dart';
import '../layout/app_separator_vertical.dart';

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

  int difficulty = 0;

  void changeDifficulty(int value) {
    difficulty += value;
    if (difficulty < -1) {
      difficulty = -1;
    }
    if (difficulty > 1) {
      difficulty = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
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
              title: 'new game?',
            ),
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const AppSeparatorVertical(value: 0.04),
                        const AppText(
                          text: 'NUMBER OF PLAYERS',
                          fontSize: 0.025,
                          letterSpacing: 0.008,
                          color: AppColors.uiColor,
                        ),
                        const AppSeparatorVertical(value: 0.02),
                        SizedBox(
                          width: AppLayout.avarage(context) * 0.4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppCircularButton(
                                icon: AppImages.minus,
                                iconColor: AppColors.uiColor,
                                color: Colors.transparent,
                                borderColor: AppColors.uiColor,
                                size: 0.075,
                                onTap: () {
                                  setState(() {
                                    changeNumberOfPlayers(-1);
                                  });
                                },
                              ),
                              AppText(
                                text: numberOfPlayers.toString(),
                                fontSize: 0.05,
                                letterSpacing: 0.01,
                                color: AppColors.uiColor,
                              ),
                              AppCircularButton(
                                icon: AppImages.plus,
                                iconColor: AppColors.uiColor,
                                color: Colors.transparent,
                                borderColor: AppColors.uiColor,
                                size: 0.075,
                                onTap: () {
                                  setState(() {
                                    changeNumberOfPlayers(1);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        const AppSeparatorVertical(value: 0.04),
                        const AppText(
                          text: 'DIFFICULTY',
                          fontSize: 0.025,
                          letterSpacing: 0.008,
                          color: AppColors.uiColor,
                        ),
                        const AppSeparatorVertical(value: 0.02),
                        AppSlider(
                            width: AppLayout.avarage(context) * 0.25,
                            height: AppLayout.avarage(context) * 0.075,
                            range: 3,
                            sliderTitle: 'difficulty',
                            sliderDescription: 'normal',
                            color: AppColors.uiColor,
                            iconColor: AppColors.uiColorDark,
                            icon: AppImages.difficulty,
                            value: difficulty,
                            add: () {
                              setState(() {
                                changeDifficulty(1);
                              });
                            },
                            remove: () {
                              setState(() {
                                changeDifficulty(-1);
                              });
                            }),
                      ],
                    ),
                  ),
                  const AppSeparatorVertical(value: 0.04),
                ],
              ),
            ),
            DialogButton(
                color: AppColors.uiColor,
                buttonText: 'confirm',
                onTap: () {
                  widget.game.newGame(difficulty, numberOfPlayers);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
