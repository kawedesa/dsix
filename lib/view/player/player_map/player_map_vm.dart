import 'package:dsix/model/player/player.dart';
import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/map/attack_button.dart';
import 'package:dsix/shared/app_widgets/map/map_info.dart';
import 'package:dsix/shared/app_widgets/map/mouse_input.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_dead_npc_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_dead_player_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_npc_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_other_player_sprite.dart';
import 'package:dsix/view/player/player_map/widgets/sprites/player_view_player_sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../model/combat/combat.dart';
import '../../../model/npc/npc.dart';

class PlayerMapVM {
  List<Widget> createNpcSprites(List<Npc> npcs, List<Player> players) {
    List<Widget> npcSprites = [];

    Path playersVisibleArea = getPlayersVisibleArea(players);

    for (Npc npc in npcs) {
      if (playersVisibleArea.contains(npc.position.getOffset())) {
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

  Path getPlayersVisibleArea(List<Player> players) {
    Path visibleArea = Path();

    for (Player player in players) {
      if (player.life.isDead() == false) {
        visibleArea.addPath(player.getVisionArea(), Offset.zero);
      }
    }
    return visibleArea;
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

  Combat combat = Combat();
  String playerMode = 'stand';

  Widget actionButtons(MapInfo mapInfo, User user, Function refresh) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AttackButton(
          isAttacking: (combat.isAttacking) ? true : false,
          icon: AppImages()
              .getItemIcon(user.player.equipment.mainHandSlot.item.name),
          color: user.color,
          darkColor: user.darkColor,
          resetAttack: () {
            combat.resetActionArea();
            refresh();
          },
          startAttack: () {
            combat.startAttack(
              mapInfo.getPlayerOnScreenPosition(user.player.position),
              user.player.position,
              user.player
                  .attack(user.player.equipment.mainHandSlot.item.attack),
            );
            playerMode = 'attack';

            refresh();
          },
          cancelAttack: () {
            cancelAction();
            refresh();
          },
        ),
        AppCircularButton(
          icon: AppImages.defense,
          iconColor: user.darkColor,
          color: user.color,
          borderColor: user.darkColor,
          size: 0.05,
          onTap: () {
            user.player.defend();
            refresh();
          },
        ),
        AppCircularButton(
          icon: AppImages.vision,
          iconColor: user.darkColor,
          color: user.color,
          borderColor: user.darkColor,
          size: 0.05,
          onTap: () {
            user.player.look();
            refresh();
          },
        ),
        AttackButton(
          isAttacking: (combat.isAttacking) ? true : false,
          color: user.color,
          darkColor: user.darkColor,
          icon: AppImages()
              .getItemIcon(user.player.equipment.offHandSlot.item.name),
          resetAttack: () {
            combat.resetActionArea();
            refresh();
          },
          startAttack: () {
            combat.startAttack(
              mapInfo.getPlayerOnScreenPosition(user.player.position),
              user.player.position,
              user.player.attack(user.player.equipment.offHandSlot.item.attack),
            );
            playerMode = 'attack';
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
          combat.confirmPlayerAttack(npcs, players, selectedPlayer);
          cancelAction();
          refresh();
        },
      );

      return attackInputWidget;
    }

    return attackInputWidget;
  }

  void cancelAction() {
    playerMode = 'stand';
    combat.cancelAction();
  }
}
