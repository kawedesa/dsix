import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:dsix/view/home/home_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeVM homeVM = HomeVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    Widget homeMenu() {
      Widget menu = const SizedBox();

      switch (homeVM.menuIndex) {
        case 0:
          return menu = GestureDetector(
            onTap: () {
              setState(() {
                homeVM.chooseRole();
              });
            },
            child: SvgPicture.asset(
              AppImages.logo,
              color: Colors.grey,
              width: MediaQuery.of(context).size.shortestSide * 0.15,
              height: MediaQuery.of(context).size.shortestSide * 0.15,
            ),
          );
        case 1:
          return menu = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextButton(
                  buttonText: 'player',
                  color: AppColors.uiColor,
                  onTap: () {
                    setState(() {
                      homeVM.playerSelection();
                    });
                  }),
              const AppSeparatorVertical(
                value: 0.01,
              ),
              AppTextButton(
                  buttonText: 'creator',
                  color: AppColors.uiColor,
                  onTap: () => homeVM.goToControllerHubView(context)),
            ],
          );
        case 2:
          return menu = Stack(children: [
            Align(
              alignment: Alignment.center,
              child: AppCircularButton(
                  color: Colors.transparent,
                  borderColor: AppColors.uiColor,
                  iconColor: AppColors.uiColor,
                  icon: AppImages.cancel,
                  onTap: () {
                    setState(() {
                      homeVM.goToTheStart();
                    });
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
            AppRadialMenu(
              buttonInfo: [
                AppCircularButton(
                  color: (game.availablePlayers.contains('blue'))
                      ? AppColors.blue
                      : Colors.transparent,
                  borderColor: AppColors.blueDark,
                  size: 0.2,
                  onTap: (game.availablePlayers.contains('blue'))
                      ? () {
                          homeVM.choosePlayer(context, game, user, 'blue');
                        }
                      : null,
                ),
                AppCircularButton(
                  color: (game.availablePlayers.contains('yellow'))
                      ? AppColors.yellow
                      : Colors.transparent,
                  borderColor: AppColors.yellowDark,
                  size: 0.2,
                  onTap: (game.availablePlayers.contains('yellow'))
                      ? () {
                          homeVM.choosePlayer(context, game, user, 'yellow');
                        }
                      : null,
                ),
                AppCircularButton(
                  color: (game.availablePlayers.contains('green'))
                      ? AppColors.green
                      : Colors.transparent,
                  borderColor: AppColors.greenDark,
                  size: 0.2,
                  onTap: (game.availablePlayers.contains('green'))
                      ? () {
                          homeVM.choosePlayer(context, game, user, 'green');
                        }
                      : null,
                ),
                AppCircularButton(
                  color: (game.availablePlayers.contains('purple'))
                      ? AppColors.purple
                      : Colors.transparent,
                  borderColor: AppColors.purpleDark,
                  size: 0.2,
                  onTap: (game.availablePlayers.contains('purple'))
                      ? () {
                          homeVM.choosePlayer(context, game, user, 'purple');
                        }
                      : null,
                ),
                AppCircularButton(
                  color: (game.availablePlayers.contains('pink'))
                      ? AppColors.pink
                      : Colors.transparent,
                  borderColor: AppColors.pinkDark,
                  size: 0.2,
                  onTap: (game.availablePlayers.contains('pink'))
                      ? () {
                          homeVM.choosePlayer(context, game, user, 'pink');
                        }
                      : null,
                ),
              ],
            ),
          ]);
      }
      return menu;
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeInOutBack,
              child: homeMenu(),
            ),
          ),
        ),
      ),
    );
  }
}
