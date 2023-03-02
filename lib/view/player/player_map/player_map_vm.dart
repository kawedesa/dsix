import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/map/attack_button.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_view/player_view_dead_npc_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_view/player_view_dead_player_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_view/player_view_npc_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_view/player_view_other_player_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_view/player_view_player_sprite.dart';
import 'package:dsix/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../model/combat/combat.dart';
import '../../../model/combat/position.dart';
import '../../../model/npc/npc.dart';

class PlayerMapVM {
  int mapSize = 320;
  double minZoom = 8;
  double maxZoom = 16;
  TransformationController? canvasController;

  Combat combat = Combat();

  TransformationController createCanvasController(
      context, Position playerPosition) {
    updateMinZoom(context);

    double dxCanvas =
        playerPosition.dx * minZoom - MediaQuery.of(context).size.width / 2;
    double dyCanvas = playerPosition.dy * minZoom -
        MediaQuery.of(context).size.height * 0.8 / 2;

    if (dxCanvas < 0) {
      dxCanvas = 0;
    }
    if (dxCanvas > mapSize * minZoom - MediaQuery.of(context).size.width) {
      dxCanvas = mapSize * minZoom - MediaQuery.of(context).size.width;
    }
    if (dyCanvas < 0) {
      dyCanvas = 0;
    }
    if (dyCanvas >
        mapSize * minZoom - MediaQuery.of(context).size.height * 0.9) {
      dyCanvas = mapSize * minZoom - MediaQuery.of(context).size.height * 0.9;
    }

    canvasController ??= TransformationController(Matrix4(minZoom, 0, 0, 0, 0,
        minZoom, 0, 0, 0, 0, minZoom, 0, -dxCanvas, -dyCanvas, 0, 1));

    return canvasController!;
  }

  void updateMinZoom(context) {
    minZoom = 2 + AppLayout.longest(context) * 0.0025;
  }

  List<Widget> createNpcSprites(List<Npc> npcs, Player player) {
    List<Widget> npcSprites = [];

    for (Npc npc in npcs) {
      if (player.canSee(npc.position)) {
        if (npc.life.isDead()) {
          npcSprites.add(PlayerViewDeadNpcSprite(
            npc: npc,
          ));
        } else {
          npcSprites.add(PlayerViewNpcSprite(
            npc: npc,
            onTap: () {},
          ));
        }
      }
    }

    return npcSprites;
  }

  List<Widget> createPlayerSprites(
      List<Player> players, Player player, Function() refresh) {
    List<Widget> playerSprites = [];

//OTHER PLAYERS
    for (Player otherPlayer in players) {
      if (otherPlayer != player) {
        if (otherPlayer.life.isDead()) {
          playerSprites.add(PlayerViewDeadPlayerSprite(
            player: otherPlayer,
            color: AppColors().getPlayerColor(otherPlayer.id),
          ));
        } else {
          playerSprites.add(PlayerViewOtherPlayerSprite(
              player: otherPlayer,
              color: AppColors().getPlayerColor(otherPlayer.id),
              onTap: () {}));
        }
      }
    }

//PLAYER
    if (player.life.isDead()) {
      playerSprites.add(PlayerViewDeadPlayerSprite(
        player: player,
        color: AppColors().getPlayerColor(player.id),
      ));
    } else {
      playerSprites.add(PlayerViewPlayerSprite(
        player: player,
        color: AppColors().getPlayerColor(player.id),
        playerMode: playerMode,
        onTap: () {},
      ));
    }

    return playerSprites;
  }

  String playerMode = 'stand';

  Widget actionButtons(User user, Function refresh) {
    return AppRadialMenu(
      maxAngle: 60,
      buttonInfo: [
        AttackButton(
          isAttacking: (playerMode == 'attack') ? true : false,
          icon: AppImages()
              .getItemIcon(user.player.equipment.mainHandSlot.item.name),
          color: user.color,
          darkColor: user.darkColor,
          resetAttack: () {
            combat.resetActionArea();
            refresh();
          },
          startAttack: (position) {
            startAttack(
              position,
              user.player.position,
              user.player.equipment.mainHandSlot.item.attack,
            );

            refresh();
          },
          cancelAttack: () {
            cancelAction();
            refresh();
          },
        ),
        // ActionButton(
        //   active: false,
        //   color: user.color,
        //   darkColor: user.darkColor,
        //   resetAction: () {},
        //   startAction: (position) {
        //     user.player.defend();
        //     refresh();
        //   },
        //   cancelAction: () {},
        // ),
        // ActionButton(
        //   active: false,
        //   color: user.color,
        //   darkColor: user.darkColor,
        //   resetAction: () {},
        //   startAction: (position) {
        //     user.player.look();
        //     refresh();
        //   },
        //   cancelAction: () {},
        // ),
        AttackButton(
          isAttacking: (playerMode == 'attack') ? true : false,
          color: user.color,
          darkColor: user.darkColor,
          icon: AppImages()
              .getItemIcon(user.player.equipment.offHandSlot.item.name),
          resetAttack: () {
            combat.resetActionArea();
            refresh();
          },
          startAttack: (position) {
            startAttack(
              position,
              user.player.position,
              user.player.equipment.offHandSlot.item.attack,
            );

            refresh();
          },
          cancelAttack: () {
            cancelAction();
            refresh();
          },
        ),
      ],
    );
  }

  Widget getAttackInput(List<Npc> npcs, List<Player> players,
      Player selectedPlayer, Function refresh) {
    Widget attackInputWidget = const SizedBox();

    if (playerMode == 'attack') {
      attackInputWidget = MouseInput(
        getMousePosition: (mousePosition) {
          combat.setMousePosition(mousePosition);
          combat.setActionArea();
          refresh();
        },
        onTap: () {
          confirmAttack(npcs, players, selectedPlayer);
          cancelAction();
          refresh();
        },
      );

      return attackInputWidget;
    }

    return attackInputWidget;
  }

  void startAttack(Position inputCenter, Position actionCenter, Attack attack) {
    playerMode = 'attack';
    combat.setInputCenterPosition(inputCenter);
    combat.setActionCenterPosition(actionCenter);
    combat.setAttack(attack);
  }

  void cancelAction() {
    playerMode = 'stand';
    combat.cancelAction();
  }

  void confirmAttack(
      List<Npc> npcs, List<Player> players, Player selectedPlayer) {
    int rawDamage = selectedPlayer.attributes.power.getRawDamage();

    for (Npc npc in npcs) {
      if (combat.areaEffect.insideArea(npc.position)) {
        npc.receiveAttack(combat.attack.damage, rawDamage);
      }
    }

    for (Player player in players) {
      if (combat.areaEffect.insideArea(player.position)) {
        player.receiveAttack(combat.attack.damage, rawDamage);
      }
    }
  }

  // Widget popUpMenu() {
  //   return (playerMode == 'menu')
  //       ? PopUpMenu(playerMode: playerMode, closeMenu: closeMenu)
  //       : const SizedBox();
  // }

  // void openMenu() {
  //   playerMode = 'menu';
  // }

  // void closeMenu() {
  //   playerMode = 'stand';
  // }

  Widget endGameButton(context, String gamePhase, Player player) {
    Widget button = const SizedBox();

    switch (gamePhase) {
      case 'end':
        button = Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors().getPlayerDarkColor(player.id).withAlpha(100),
            ),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(
                  color: AppColors().getPlayerColor(player.id),
                  buttonText: 'end',
                  onTap: () {
                    goToHomeView(context);
                  }),
            ),
          ],
        );

        playerMode = 'end';

        break;
    }

    return button;
  }

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
}
