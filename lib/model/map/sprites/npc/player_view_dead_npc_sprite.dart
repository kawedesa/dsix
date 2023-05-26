import 'package:dsix/model/map/sprites/hit_box_sprite.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_animations.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/model/item/npc_loot_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewDeadNpcSprite extends StatelessWidget {
  final Npc npc;
  const PlayerViewDeadNpcSprite({
    super.key,
    required this.npc,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: npc.position.dx - (npc.size / 2),
      top: npc.position.dy - (npc.size / 2),
      child: GestureDetector(
        child: SizedBox(
          width: npc.size,
          height: npc.size,
          child: Stack(
            children: [
              (npc.loot.isEmpty)
                  ? const SizedBox()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: TransparentPointer(
                        transparent: true,
                        child: SizedBox(
                          width: npc.size / 1.25,
                          height: npc.size / 1.25,
                          child: const RiveAnimation.asset(
                            AppAnimations.loot,
                          ),
                        ),
                      ),
                    ),
              TransparentPointer(
                transparent: true,
                child: SvgPicture.asset(
                  AppImages().getDeadNpcSprite(npc.name),
                  fit: BoxFit.fill,
                ),
              ),
              HitBoxSprite(
                size: npc.size,
                hitBox: npc.hitBox.deadNpcHitBox(npc.name),
              ),
            ],
          ),
        ),
        onTap: () {
          if (user.player.position
                  .getDistanceFromPoint(npc.position.getOffset()) <
              12) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NpcLootDialog(
                    id: npc.id,
                  );
                });
          } else {
            snackbarKey.currentState?.showSnackBar(
                AppSnackBar().getSnackBar('too far'.toUpperCase(), user.color));
          }
        },
      ),
    );
  }
}
