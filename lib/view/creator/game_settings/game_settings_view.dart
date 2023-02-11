import 'package:dsix/shared/app_widgets/dialog/confirm_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../model/user.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
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
    final user = Provider.of<User>(context);

    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AppSeparatorVertical(value: 0.005),
          AppTitle(title: 'round', color: user.color),
          AppTitle(title: 'difficulty', color: user.color),
          AppCircularButton(
              color: Colors.black,
              borderColor: user.color,
              iconColor: user.color,
              icon: AppImages.cancel,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ConfirmDialog(
                      title: 'delete game?',
                      color: user.color,
                      confirm: () {
                        game.deleteGame();
                        goToHomeView(context);
                      },
                    );
                  },
                );
              },
              size: 0.08),
          const AppSeparatorVertical(value: 0.005),
        ],
      ),
    );
  }
}
