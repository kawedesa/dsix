import 'package:dsix/model/game/game.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';
import 'package:dsix/shared/app_widgets/text/app_bar_title.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:dsix/view/player/race/race_vm.dart';
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
        toolbarHeight: AppLayout.height(context) * 0.04,
        leading: Row(
          children: [
            const AppSeparatorHorizontal(
              value: 0.003,
            ),
            GestureDetector(
              onTap: () {
                _raceVM.goBackToPlayerSelection(context, game, user.player.id);
              },
              child: Icon(
                Icons.exit_to_app,
                color: user.darkColor,
                size: AppLayout.height(context) * 0.03,
              ),
            ),
          ],
        ),
        backgroundColor: user.color,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: AppLayout.shortest(context) * 0.8,
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
                        size: 0.075),
                    SizedBox(
                      width: AppLayout.shortest(context) * 0.5,
                      height: AppLayout.shortest(context) * 0.55,
                      child: Stack(
                        children: [
                          Align(
                            alignment: const Alignment(0.0, -1.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppCircularButton(
                                  color: Colors.transparent,
                                  borderColor: user.color,
                                  icon: (_raceVM.selectedSex == 'female')
                                      ? AppImages.female
                                      : AppImages.male,
                                  iconColor: user.color,
                                  size: 0.04,
                                  onTap: () {
                                    setState(() {
                                      _raceVM.changeSex();
                                    });
                                  },
                                ),
                                const AppSeparatorHorizontal(value: 0.01),
                                AppTitle(
                                  title: _raceVM.selectedRace.name,
                                  color: user.color,
                                ),
                              ],
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: PlayerSpriteImage(
                                  color: user.color,
                                  race: _raceVM.selectedRace.name,
                                  sex: _raceVM.selectedSex)),
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
                        size: 0.075),
                  ],
                ),
                const AppSeparatorVertical(value: 0.025),
                SizedBox(
                    width: AppLayout.avarage(context) * 0.2,
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
