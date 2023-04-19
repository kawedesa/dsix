import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/model/item/npc_loot_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          child: SvgPicture.asset(
            (npc.loot.isEmpty)
                ? AppImages.normalChestOpen
                : AppImages.normalChestClosed,
            width: 10,
            height: 10,
          ),
          onTap: () {
            if (user.player.position
                    .getDistanceFromPoint(npc.position.getOffset()) <
                12) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NpcLootDialog(
                      npc: npc,
                    );
                  });
            } else {
              snackbarKey.currentState?.showSnackBar(AppSnackBar()
                  .getSnackBar('too far'.toUpperCase(), user.color));
            }
          },
        ),
      ),
    );
  }
}