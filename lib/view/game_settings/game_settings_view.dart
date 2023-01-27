import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/dialog/app_new_game_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/game/game.dart';
import '../../shared/app_images.dart';
import '../../shared/app_widgets/button/app_circular_button.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  // final GameSettingsVM _gameSettingsVM = GameSettingsVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    return (game.phase == 'empty')
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                  buttonText: 'new game',
                  color: AppColors.uiColor,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AppNewGameDialog(
                          game: game,
                        );
                      },
                    );
                  }),
            ],
          )
        : Align(
            alignment: Alignment.center,
            child: AppCircularButton(
                color: Colors.black,
                borderColor: AppColors.uiColor,
                iconColor: AppColors.uiColor,
                icon: AppImages.cancel,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AppConfirmDialog(
                        title: 'delete game?',
                        color: AppColors.uiColor,
                        confirm: () {
                          game.deleteGame();
                        },
                      );
                    },
                  );
                },
                size: 0.08),
          );
  }
}
