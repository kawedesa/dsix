import 'package:dsix/model/user.dart';
import 'package:dsix/view/home/widgets/choose_player_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../shared/app_colors.dart';
import '../../../shared/app_images.dart';
import '../../../shared/app_layout.dart';
import '../../../shared/app_widgets/button/app_text_button.dart';
import '../../../shared/app_widgets/dialog/new_game_dialog.dart';
import '../../../shared/app_widgets/layout/app_separator_vertical.dart';
import '../../creator/creator_view/creator_view.dart';
import 'create_player_menu.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({
    super.key,
  });

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  int index = 0;

  void goBack() {
    setState(() {
      index = 1;
    });
  }

  void chooseRole() {
    index = 1;
  }

  void playerSelection() {
    index = 2;
  }

  void chooseCreator(context, User user) {
    goToCreatorView(context);
  }

  void goToCreatorView(context) {
    Route newRoute = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CreatorView(),
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
    final game = Provider.of<Game>(context);

    Widget menu = const SizedBox();

    switch (index) {
      case 0:
        return menu = GestureDetector(
          onTap: () {
            setState(() {
              chooseRole();
            });
          },
          child: SvgPicture.asset(
            AppImages.logo,
            color: Colors.grey,
            width: AppLayout.avarage(context) * 0.15,
            height: AppLayout.avarage(context) * 0.15,
          ),
        );

      case 1:
        return (game.phase == 'empty')
            ? AppTextButton(
                buttonText: 'new game',
                color: AppColors.uiColor,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NewGameDialog(
                        game: game,
                      );
                    },
                  );
                })
            : menu = Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppTextButton(
                      buttonText: 'player',
                      color: AppColors.uiColor,
                      onTap: () {
                        setState(() {
                          playerSelection();
                        });
                      }),
                  const AppSeparatorVertical(
                    value: 0.01,
                  ),
                  AppTextButton(
                      buttonText: 'creator',
                      color: AppColors.uiColor,
                      onTap: () => chooseCreator(context, user)),
                ],
              );
      case 2:
        return (game.phase == 'creation')
            ? CreatePlayerMenu(
                goBack: () {
                  goBack();
                },
              )
            : ChoosePlayerMenu(
                goBack: () {
                  goBack();
                },
              );
    }
    return menu;
  }
}
