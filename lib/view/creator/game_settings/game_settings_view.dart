import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/dialog/confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../model/user.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
import '../../../shared/app_widgets/button/app_text_button.dart';
import '../../home/home_view.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({Key? key}) : super(key: key);

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {
  void goToHomeView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(-1.0, 0.0);
        var end = const Offset(0.0, 0.0);
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );

    Navigator.of(context).push(newRoute);
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppSeparatorVertical(value: 0.005),
          AppTextButton(
              buttonText: 'add player',
              color: AppColors.uiColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      title: 'add player?',
                      color: AppColors.uiColor,
                      confirm: () {},
                    );
                  },
                );
              }),
          const AppSeparatorVertical(value: 0.005),
          AppTextButton(
              buttonText: 'remove player',
              color: AppColors.uiColor,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      title: 'remove player?',
                      color: AppColors.uiColor,
                      confirm: () {},
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
                        goToHomeView(context);
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
