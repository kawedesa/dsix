import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/text/app_bar_title.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:dsix/shared/app_widgets/player/player_sprite.dart';
import 'package:dsix/view/race/race_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RaceView extends StatefulWidget {
  const RaceView({Key? key}) : super(key: key);

  @override
  State<RaceView> createState() => _RaceViewState();
}

class _RaceViewState extends State<RaceView> {
  final RaceVM _raceVM = RaceVM();

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTitle(
          title: 'choose your race',
          color: user.darkColor,
        ),
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.07,
        leading: Padding(
          padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.01),
          child: GestureDetector(
            onTap: () {
              _raceVM.goBackToPlayerSelection(context, game, user.player!.id);
            },
            child: Icon(
              Icons.exit_to_app,
              color: user.darkColor,
              size: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
        ),
        backgroundColor: user.color,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.shortestSide * 0.9,
            height: MediaQuery.of(context).size.height * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppCircularButton(
                        color: Colors.transparent,
                        borderColor: user.color,
                        iconColor: user.color,
                        icon: AppImages.left,
                        onTap: () {
                          setState(() {
                            _raceVM.changeRace(-1);
                          });
                        },
                        size: 0.125),
                    SizedBox(
                      width: MediaQuery.of(context).size.shortestSide * 0.5,
                      height: MediaQuery.of(context).size.shortestSide * 0.55,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: AppTitle(
                              title: _raceVM.selectedRace.name,
                              color: user.color,
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: PlayerSprite(
                                  race: _raceVM.selectedRace.name)),
                        ],
                      ),
                    ),
                    AppCircularButton(
                        color: Colors.transparent,
                        borderColor: user.color,
                        iconColor: user.color,
                        icon: AppImages.right,
                        onTap: () {
                          setState(() {
                            _raceVM.changeRace(1);
                          });
                        },
                        size: 0.125),
                  ],
                ),
                const AppSeparatorVertical(value: 0.025),
                SizedBox(
                    width: MediaQuery.of(context).size.shortestSide * 0.4,
                    child: _raceVM.raceBonusIcons(context, user)),
                const AppSeparatorVertical(value: 0.025),
                AppTextButton(
                    buttonText: 'choose',
                    color: user.color,
                    onTap: () {
                      _raceVM.setRace(context, user);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
