import 'package:dsix/model/game/game.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_slider.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_dialog_title.dart';
import 'package:flutter/material.dart';
import '../../app_images.dart';
import '../layout/app_separator_vertical.dart';
import '../text/app_title.dart';

class AppNewGameDialog extends StatefulWidget {
  final Game game;
  const AppNewGameDialog({
    required this.game,
    super.key,
  });

  @override
  State<AppNewGameDialog> createState() => _AppNewGameDialogState();
}

class _AppNewGameDialogState extends State<AppNewGameDialog> {
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
        width: AppLayout.shortest(context) * 0.6,
        decoration: BoxDecoration(
          color: AppColors.uiColor,
          border: Border.all(
            color: AppColors.uiColor,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AppDialogTitle(
              color: AppColors.uiColor,
              title: 'new game?',
            ),
            Container(
              height: AppLayout.shortest(context) * 0.3,
              color: Colors.black,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        const AppSeparatorVertical(value: 0.01),
                        const AppTitle(
                          title: 'difficulty',
                          color: AppColors.uiColor,
                        ),
                        AppSlider(
                            width: AppLayout.shortest(context) * 0.3,
                            height: AppLayout.shortest(context) * 0.09,
                            range: 3,
                            sliderTitle: 'difficulty',
                            sliderDescription: 'normal',
                            color: AppColors.uiColor,
                            iconColor: AppColors.uiColorDark,
                            icon: AppImages.sword,
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
                ],
              ),
            ),
            AppDialogButton(
                color: AppColors.uiColor,
                buttonText: 'confirm',
                onTap: () {
                  widget.game.newGame(difficulty);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
