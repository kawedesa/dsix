import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/text/app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../model/player/player.dart';
import '../../../model/user/user.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/images/app_images.dart';
import '../../../shared/shared_widgets/app_radial_menu.dart';
import '../../../shared/shared_widgets/button/app_circular_button.dart';
import '../../player/race/race_view.dart';

class CreatePlayerMenu extends StatefulWidget {
  final Function() goBack;
  const CreatePlayerMenu({super.key, required this.goBack});

  @override
  State<CreatePlayerMenu> createState() => _CreatePlayerMenuState();
}

class _CreatePlayerMenuState extends State<CreatePlayerMenu> {
  Widget createPlayerMenu(Game game, User user) {
    List<AppCircularButton> players = [];

    for (int i = 0; i < game.numberOfPlayers; i++) {
      String id = game.availablePlayers[i];

      players.add(
        AppCircularButton(
          color: (game.choosenPlayers.contains(id))
              ? AppColors().getPlayerColor(id).withAlpha(15)
              : AppColors().getPlayerColor(id),
          borderColor: AppColors().getPlayerDarkColor(id),
          size: 0.1,
          onTap: (game.choosenPlayers.contains(id))
              ? null
              : () {
                  choosePlayer(context, game, user, id);
                },
        ),
      );
    }

    Widget menu = Center(
      child: SizedBox(
        width: AppLayout.avarage(context) * 0.3,
        height: AppLayout.avarage(context) * 0.3,
        child: AppRadialMenu(
          maxAngle: 360,
          buttonInfo: players,
        ),
      ),
    );
    return menu;
  }

  void choosePlayer(context, Game game, User user, String color) {
    newPlayer(game, user, color);
    game.choosePlayer(color);
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
            size: 0.03),
      ),
      Align(
        alignment: const Alignment(0, -0.75),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 650),
          tween: Tween(begin: 0, end: 255),
          builder: (_, double aplhaValue, __) {
            return AppTitle(
                title: 'choose a color'.toUpperCase(),
                color: Color.fromARGB(aplhaValue.toInt(), 200, 200, 200));
          },
        ),
      ),
      createPlayerMenu(game, user),
    ]);
  }
}
