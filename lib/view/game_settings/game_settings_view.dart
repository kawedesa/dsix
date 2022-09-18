import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/dialog/app_confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/view/game_settings/game_settings_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/app_widgets/text/app_bar_title.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  final GameSettingsVM _gameSettingsVM = GameSettingsVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const AppBarTitle(
          title: 'game settings',
          color: Colors.black,
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        leading: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.exit_to_app,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
        ),
        backgroundColor: AppColors.uiColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
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
                  buttonText: 'dificulty',
                  color: AppColors.uiColor,
                  onTap: () {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: AppColors.uiColor,
        items: [
          BottomNavigationBarItem(
              label: 'settings',
              icon: SvgPicture.asset(
                AppImages.settings,
                width: MediaQuery.of(context).size.shortestSide * 0.08,
                height: MediaQuery.of(context).size.shortestSide * 0.08,
              )),
          BottomNavigationBarItem(
              label: 'map',
              icon: SvgPicture.asset(
                AppImages.map,
                width: MediaQuery.of(context).size.shortestSide * 0.08,
                height: MediaQuery.of(context).size.shortestSide * 0.08,
              )),
        ],
      ),
    );
  }
}
