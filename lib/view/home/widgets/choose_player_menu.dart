import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/player/player.dart';
import '../../../model/user.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_widgets/app_radial_menu.dart';
import '../../../shared/app_widgets/button/app_circular_button.dart';
import '../../player/player_view/player_view.dart';

class ChoosePlayerMenu extends StatefulWidget {
  final Function() goBack;
  const ChoosePlayerMenu({super.key, required this.goBack});

  @override
  State<ChoosePlayerMenu> createState() => _ChoosePlayerMenuState();
}

class _ChoosePlayerMenuState extends State<ChoosePlayerMenu> {
  Widget createPlayerMenu(
    context,
    User user,
    List<Player> players,
  ) {
    List<AppCircularButton> buttons = [];

    for (Player player in players) {
      buttons.add(
        AppCircularButton(
          color: AppColors().getPlayerColor(player.id),
          borderColor: AppColors().getPlayerDarkColor(player.id),
          size: 0.1,
          onTap: () {
            user.selectPlayer(player);
            goToPlayerView(context);
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
          buttonInfo: buttons,
        ),
      ),
    );
    return menu;
  }

  void goToPlayerView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const PlayerView(),
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
    final user = Provider.of<User>(context);
    final players = Provider.of<List<Player>>(context);

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
      createPlayerMenu(
        context,
        user,
        players,
      ),
    ]);
  }
}
