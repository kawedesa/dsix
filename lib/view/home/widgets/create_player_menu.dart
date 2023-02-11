import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/game/game.dart';
import '../../../model/player/player.dart';
import '../../../model/user.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/app_radial_menu.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
import '../../../shared/app_widgets/text/app_text.dart';
import '../../player/race/race_view.dart';

class CreatePlayerMenu extends StatefulWidget {
  final Function() goBack;
  const CreatePlayerMenu({super.key, required this.goBack});

  @override
  State<CreatePlayerMenu> createState() => _CreatePlayerMenuState();
}

class _CreatePlayerMenuState extends State<CreatePlayerMenu> {
  AppRadialMenu createPlayerMenu(Game game, User user) {
    List<AppCircularButton> players = [];
    List<AppCircularButton> availablePlayers = [
      AppCircularButton(
        color: (game.availablePlayers.contains('blue'))
            ? AppColors.blue
            : AppColors.blue.withAlpha(15),
        borderColor: AppColors.blueDark,
        size: 0.2,
        onTap: (game.availablePlayers.contains('blue'))
            ? () {
                choosePlayer(context, game, user, 'blue');
              }
            : null,
      ),
      AppCircularButton(
        color: (game.availablePlayers.contains('yellow'))
            ? AppColors.yellow
            : AppColors.yellow.withAlpha(15),
        borderColor: AppColors.yellowDark,
        size: 0.2,
        onTap: (game.availablePlayers.contains('yellow'))
            ? () {
                choosePlayer(context, game, user, 'yellow');
              }
            : null,
      ),
      AppCircularButton(
        color: (game.availablePlayers.contains('green'))
            ? AppColors.green
            : AppColors.green.withAlpha(15),
        borderColor: AppColors.greenDark,
        size: 0.2,
        onTap: (game.availablePlayers.contains('green'))
            ? () {
                choosePlayer(context, game, user, 'green');
              }
            : null,
      ),
      AppCircularButton(
        color: (game.availablePlayers.contains('purple'))
            ? AppColors.purple
            : AppColors.purple.withAlpha(15),
        borderColor: AppColors.purpleDark,
        size: 0.2,
        onTap: (game.availablePlayers.contains('purple'))
            ? () {
                choosePlayer(context, game, user, 'purple');
              }
            : null,
      ),
      AppCircularButton(
        color: (game.availablePlayers.contains('pink'))
            ? AppColors.pink
            : AppColors.pink.withAlpha(15),
        borderColor: AppColors.pinkDark,
        size: 0.2,
        onTap: (game.availablePlayers.contains('pink'))
            ? () {
                choosePlayer(context, game, user, 'pink');
              }
            : null,
      ),
    ];

    for (int i = 0; i < game.numberOfPlayers; i++) {
      players.add(availablePlayers[i]);
    }

    AppRadialMenu menu = AppRadialMenu(
      buttonInfo: players,
    );
    return menu;
  }

  void choosePlayer(context, Game game, User user, String color) {
    newPlayer(game, user, color);
    game.removeAvailablePlayer(color);
    goToRaceView(context);
  }

  void newPlayer(Game game, User user, String color) {
    Player newPlayer = Player.newPlayer(color);
    user.selectPlayer(newPlayer);
    newPlayer.set();
  }

  void goToRaceView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const RaceView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
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

    return Stack(children: [
      Align(
        alignment: Alignment.center,
        child: AppCircularButton(
            color: Colors.black,
            borderColor: AppColors.uiColor,
            iconColor: AppColors.uiColor,
            icon: AppImages.cancel,
            onTap: () {
              widget.goBack();
            },
            size: 0.08),
      ),
      Align(
        alignment: const Alignment(0, -0.75),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 650),
          tween: Tween(begin: 0, end: 255),
          builder: (_, double aplhaValue, __) {
            return AppText(
                text: 'choose a color'.toUpperCase(),
                fontSize: 0.04,
                letterSpacing: 0.008,
                color: Color.fromARGB(aplhaValue.toInt(), 200, 200, 200));
          },
        ),
      ),
      createPlayerMenu(game, user),
    ]);
  }
}
