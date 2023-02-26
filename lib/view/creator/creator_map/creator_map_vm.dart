import 'package:dsix/model/combat/attack.dart';
import 'package:dsix/model/combat/combat.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/spawner/spawner.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_widgets/app_radial_menu.dart';
import 'package:dsix/shared/app_widgets/map/game_pad.dart';
import 'package:dsix/shared/app_widgets/map/map_input_controller.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_dead_npc_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_dead_player_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_action_npc_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_edit_npc_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_player_sprite.dart';
import 'package:dsix/shared/app_widgets/map/sprite/creator_view/creator_view_spawner_sprite.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/view/creator/creator_map/widgets/selected_npc_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../model/game/game.dart';
import '../../../model/npc/npc.dart';
import '../../../shared/app_widgets/button/app_text_button.dart';
import '../../home/home_view.dart';
import 'widgets/game_creation_menu.dart';

class CreatorMapVM {
  int mapSize = 320;
  double minZoom = 8;
  double maxZoom = 16;
  TransformationController? canvasController;

  TransformationController createCanvasController(context) {
    updateMinZoom(context);

    canvasController ??= TransformationController(Matrix4(
        minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, minZoom, 0, 0, 0, 0, 1));

    return canvasController!;
  }

  void updateMinZoom(context) {
    minZoom = 2 + AppLayout.longest(context) * 0.0025;
  }

  List<Widget> createSpawnerSprites(String gamePhase, List<Spawner> spawners) {
    if (gamePhase == 'action') {
      return [];
    }

    List<Widget> spawnerSprites = [];

    for (Spawner spawner in spawners) {
      spawnerSprites.add(CreatorViewSpawnerSprite(
        spawner: spawner,
      ));
    }

    return spawnerSprites;
  }

  Combat combat = Combat();
  Npc? selectedNpc;

  void updateSelectedNpc(List<Npc> npcs) {
    if (selectedNpc == null) {
      return;
    }

    for (Npc npc in npcs) {
      if (selectedNpc!.id == npc.id) {
        selectedNpc = npc;
      }
    }
  }

  Widget mapInputController(Function refresh) {
    if (selectedNpc == null) {
      return const SizedBox();
    } else {
      return MapInputController(onTap: () {
        deselectNpc(refresh);
      });
    }
  }

  void selectNpc(Npc npc, Function refresh) {
    if (npc.life.isDead()) {
      selectedNpc = null;
      refresh();
      return;
    }
    selectedNpc = npc;
    refresh();
  }

  void deselectNpc(Function refresh) {
    if (selectedNpc == null) {
      return;
    } else {
      selectedNpc = null;
      refresh();
    }
  }

  Widget selectedNpcUi() {
    if (selectedNpc == null) {
      return const SizedBox();
    } else {
      return SelectedNpcUi(npc: selectedNpc!);
    }
  }

  Widget actionButtons(String gamePhase, List<Npc> npcs, List<Player> players,
      Function refresh) {
    if (selectedNpc == null) {
      return const SizedBox();
    }

    if (gamePhase == 'creation') {
      return const SizedBox();
    }

    List<Widget> abilityButtons = [];

    for (Attack attack in selectedNpc!.attacks) {
      abilityButtons.add(GamePad(
        color: AppColors.uiColor,
        cancelColor: AppColors.cancel,
        onPanStart: () {},
        onPanUpdate: (angle, distance) {
          combat.setAttack(
            angle,
            distance,
            selectedNpc!.position,
            attack,
          );
          refresh();
        },
        onPanEnd: () {
          combat.confirmNpcAttack(npcs, players, selectedNpc!, attack);
          combat.resetAttack();
          refresh();
        },
        cancel: () {
          combat.resetAttack();
          refresh();
        },
      ));
    }

    return Align(
      alignment: const Alignment(0.0, -2.0),
      child: AppRadialMenu(
        maxAngle: 120,
        buttonInfo: abilityButtons,
        menuSize: 0.8,
      ),
    );
  }

  List<Widget> createNpcSprites(
      String gamePhase, List<Npc> npcs, Function() refresh) {
    List<Widget> npcSprites = [];

    switch (gamePhase) {
      case 'creation':
        for (Npc npc in npcs) {
          npcSprites.add(CreatorViewEditNpcSprite(
            npc: npc,
            selected: (npc == selectedNpc) ? true : false,
            selectNpc: () {
              selectNpc(npc, refresh);
            },
          ));
        }

        break;
      case 'action':
        for (Npc npc in npcs) {
          if (npc.life.isDead()) {
            npcSprites.add(CreatorViewDeadNpcSprite(
              npc: npc,
            ));
          } else {
            npcSprites.add(CreatorViewActionNpcSprite(
              npc: npc,
              selected: (npc == selectedNpc) ? true : false,
              selectNpc: () {
                selectNpc(npc, refresh);
              },
            ));
          }
        }

        break;
    }

    return npcSprites;
  }

  List<Widget> createPlayerSprites(List<Player> players, List<Npc> npcs) {
    List<Widget> playerSprites = [];

    Path npcVisibleArea = getNpcsVisibleArea(npcs);

    for (Player player in players) {
      if (npcVisibleArea.contains(player.position.getOffset())) {
        if (player.life.isDead()) {
          playerSprites.add(CreatorViewDeadPlayerSprite(
            player: player,
            color: AppColors().getPlayerColor(player.id),
          ));
        } else {
          playerSprites.add(CreatorViewPlayerSprite(
            player: player,
            color: AppColors().getPlayerColor(player.id),
            onTap: () {},
          ));
        }
      }
    }

    return playerSprites;
  }

  Path getNpcsVisibleArea(List<Npc> npcs) {
    Path visibleArea = Path();

    for (Npc npc in npcs) {
      if (npc.life.isDead() == false) {
        visibleArea.addOval(Rect.fromCircle(
            center: Offset(npc.position.dx, npc.position.dy),
            radius: npc.vision.getRange() / 2));
      }
    }
    return visibleArea;
  }

  Widget gameCreationMenu(
      String gamePhase,
      Function(
    String,
    Color,
  )
          displaySnackbar) {
    if (gamePhase == 'creation') {
      return GameCreationMenu(
        displaySnackbar: (text, color) {
          displaySnackbar(text, color);
        },
      );
    } else {
      return const SizedBox();
    }
  }

  bool popUpMenuIsOpen = false;

  void openMenu() {
    popUpMenuIsOpen = true;
  }

  void closeMenu() {
    popUpMenuIsOpen = false;
  }

  void checkForEndGame(Game game, List<Npc> npcs, List<Player> players) {
    int deadNpcs = 0;
    int deadPlayers = 0;

    for (Npc npc in npcs) {
      if (npc.life.isDead()) {
        deadNpcs++;
      }
    }
    for (Player player in players) {
      if (player.life.isDead()) {
        deadPlayers++;
      }
    }

    if (deadNpcs == npcs.length && deadNpcs != 0) {
      game.endGame();
    }
    if (deadPlayers == players.length && deadPlayers != 0) {
      game.endGame();
    }
  }

  Widget endGameButton(context, Game game) {
    Widget button = const SizedBox();

    switch (game.phase) {
      case 'end':
        button = Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.uiColorDark.withAlpha(100),
            ),
            Align(
              alignment: Alignment.center,
              child: AppTextButton(
                  color: AppColors.uiColor,
                  buttonText: 'end game',
                  onTap: () {
                    goToHomeView(context);
                  }),
            ),
          ],
        );

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
