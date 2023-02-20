import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/user.dart';

class PopUpMenu extends StatelessWidget {
  final bool popUpMenuIsOpen;
  final Function() closeMenu;

  const PopUpMenu(
      {super.key, required this.popUpMenuIsOpen, required this.closeMenu});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: user.player.position.dx - AppLayout.shortest(context) * 0.05,
      top: user.player.position.dy - AppLayout.shortest(context) * 0.05,
      child: SizedBox(
        width: AppLayout.shortest(context) * 0.1,
        height: AppLayout.shortest(context) * 0.1,
        child: Center(
          child: AnimatedContainer(
              curve: Curves.easeOutCubic,
              duration: const Duration(milliseconds: 400),
              height:
                  (popUpMenuIsOpen) ? AppLayout.shortest(context) * 0.1 : 0.0,
              width:
                  (popUpMenuIsOpen) ? AppLayout.shortest(context) * 0.1 : 0.0,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: AppCircularButton(
                    onTap: () {
                      closeMenu();
                    },
                    color: user.color.withAlpha(100),
                    borderColor: user.color,
                    size: 0.025,
                  ),
                ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: AppCircularButton(
                //       color: user.color, borderColor: user.color, size: 0.03),
                // ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: AppCircularButton(
                //       color: user.color, borderColor: user.color, size: 0.03),
                // ),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: AppCircularButton(
                //       color: user.color, borderColor: user.color, size: 0.03),
                // ),
              ])),
        ),
      ),
    );
  }
}


// class PlayerMenu extends StatelessWidget {
//   final Function()? refresh;
//   final Player? player;
//   PlayerMenu({Key? key, this.refresh, @required this.player}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final game = Provider.of<Game>(context);

//     return Positioned(
//       left: player!.location!.dx! - MediaQuery.of(context).size.height * 0.04,
//       top: player!.location!.dy! - MediaQuery.of(context).size.height * 0.045,
//       child: SizedBox(
//         width: MediaQuery.of(context).size.height * 0.08,
//         height: MediaQuery.of(context).size.height * 0.08,
//         child: Center(
//           child: AnimatedContainer(
//             curve: Curves.fastLinearToSlowEaseIn,
//             duration: Duration(milliseconds: 400),
//             height: (player!.mode == 'menu')
//                 ? MediaQuery.of(context).size.height * 0.08
//                 : 0.0,
//             width: (player!.mode == 'menu')
//                 ? MediaQuery.of(context).size.height * 0.08
//                 : 0.0,
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.topCenter,
//                   child: ActionButton(
//                     player: player,
//                     action: 'attack',
//                     onTap: () {
//                       player!.attackMode();
//                       player!.updateMode();
//                       refresh!();
//                     },
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: ActionButton(
//                     player: player,
//                     action: 'defend',
//                     onTap: () {
//                       player!.defend();
//                       player!.menuMode();

//                       game.round!.takeTurn(game.id!, player!);
//                     },
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ActionButton(
//                     player: player,
//                     action: 'look',
//                     onTap: () {
//                       player!.look();
//                       player!.menuMode();

//                       game.round!.takeTurn(game.id!, player!);
//                     },
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: IventoryButton(
//                     player: player,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }