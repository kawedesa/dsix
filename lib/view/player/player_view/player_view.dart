import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_bar_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/text/app_bar_text.dart';
import 'package:dsix/view/player/player_view/player_vm.dart';
import 'package:dsix/view/player/player_view/widgets/bottom_navigation_player.dart';
import 'package:dsix/view/player/player_view/widgets/page_view_content_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/player/player.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key}) : super(key: key);

  @override
  State<PlayerView> createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  final PlayerVM _playerVM = PlayerVM();

  void refresh() {
    setState(() {});
  }

  void displaySnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
          height: AppLayout.avarage(context) * 0.05,
          child: Center(
            child: AppBarText(
              text: text,
              fontSize: 0.03,
              letterSpacing: 0.005,
              color: Colors.white,
            ),
          )),
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final players = Provider.of<List<Player>>(context);
    user.updatePlayer(players);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: AppLayout.height(context) * 0.04,
        backgroundColor: user.color,
        centerTitle: false,
        leading: Row(
          children: [
            const AppSeparatorHorizontal(
              value: 0.003,
            ),
            GestureDetector(
              onTap: () {
                if (user.player.ready) {
                  _playerVM.goToHomeView(context);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Icon(
                Icons.exit_to_app,
                color: user.darkColor,
                size: AppLayout.height(context) * 0.03,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBarCircularButton(
                  icon: AppImages.health,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.03),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppBarText(
                text: '${user.player.life.current}/${user.player.life.max}',
                fontSize: 0.02,
                letterSpacing: 0.002,
                color: Colors.white,
              ),
              const AppSeparatorHorizontal(
                value: 0.025,
              ),
              AppBarCircularButton(
                  icon: AppImages.weight,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.03),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppBarText(
                text:
                    '${user.player.equipment.currentWeight}/${user.player.equipment.maxWeight}',
                fontSize: 0.02,
                letterSpacing: 0.002,
                color: Colors.white,
              ),
              const AppSeparatorHorizontal(
                value: 0.025,
              ),
              AppBarCircularButton(
                  icon: AppImages.money,
                  iconColor: user.darkColor,
                  color: Colors.transparent,
                  borderColor: user.darkColor,
                  size: 0.03),
              const AppSeparatorHorizontal(
                value: 0.01,
              ),
              AppBarText(
                text: '${user.player.equipment.money}',
                fontSize: 0.02,
                letterSpacing: 0.002,
                color: Colors.white,
              ),
              const AppSeparatorHorizontal(
                value: 0.05,
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: PageViewContentPlayer(
          controller: _playerVM.pageController,
          displaySnackbar: (p0, p1) => displaySnackBar(p0, p1),
          refresh: () => refresh(),
        ),
      ),
      bottomNavigationBar: Container(
        color: user.color,
        height: AppLayout.height(context) * 0.06,
        child: Align(
          alignment: Alignment.center,
          child: BottomNavigationPlayer(
              currentPage: _playerVM.selectedPage,
              changePage: (number) {
                _playerVM.changePage(number);
              },
              refresh: () {
                refresh();
              }),
        ),
      ),
    );
  }
}
