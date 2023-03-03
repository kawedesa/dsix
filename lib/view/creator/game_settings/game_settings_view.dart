import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/dialog/confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/creator/game_settings/game_settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../shared/app_widgets/button/app_text_button.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  final GameSettingsVM _gameSettingsVM = GameSettingsVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final players = Provider.of<List<Player>>(context);

    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppSeparatorVertical(value: 0.005),
          AppTextButton(
              buttonText: 'new round',
              color: AppColors.uiColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      title: 'start new round?',
                      color: AppColors.uiColor,
                      confirm: () {
                        _gameSettingsVM.newRound(game, players);
                      },
                    );
                  },
                );
              }),
          const AppSeparatorVertical(value: 0.005),
          AppTextButton(
              buttonText: 'delete game',
              color: AppColors.uiColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      title: 'delete game?',
                      color: AppColors.uiColor,
                      confirm: () {
                        game.deleteGame();
                        _gameSettingsVM.goToHomeView(context);
                      },
                    );
                  },
                );
              }),
          const AppSeparatorVertical(value: 0.005),
        ],
      ),
    );
  }
}
