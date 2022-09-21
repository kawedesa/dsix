import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/game_settings/game_settings_vm.dart';
import 'package:flutter/material.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  final GameSettingsVM _gameSettingsVM = GameSettingsVM();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextButton(
            buttonText: 'new game',
            color: AppColors.uiColor,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AppConfirmDialog(
                    title: 'new game?',
                    confirm: () => _gameSettingsVM.newGame(),
                    color: AppColors.uiColor,
                  );
                },
              );
            }),
        const AppSeparatorVertical(
          value: 0.01,
        ),
        AppTextButton(
            buttonText: 'dificulty', color: AppColors.uiColor, onTap: () {}),
      ],
    );
  }
}
