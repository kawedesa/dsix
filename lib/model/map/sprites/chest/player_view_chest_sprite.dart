import 'package:dsix/model/item/chest_loot_dialog.dart';
import 'package:dsix/model/chest/chest.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PlayerViewChestSprite extends StatelessWidget {
  final Chest chest;

  const PlayerViewChestSprite({super.key, required this.chest});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: chest.position.dx - (chest.size / 2),
      top: chest.position.dy - (chest.size / 2),
      child: GestureDetector(
        onTap: () {
          if (user.player.position
                  .getDistanceFromPoint(chest.position.getOffset()) >
              12) {
            snackbarKey.currentState?.showSnackBar(
                AppSnackBar().getSnackBar('too far'.toUpperCase(), user.color));
            return;
          }

          if (chest.locked && user.player.equipment.hasKey() == false) {
            snackbarKey.currentState?.showSnackBar(AppSnackBar()
                .getSnackBar('you need a key'.toUpperCase(), user.color));
            return;
          }

          if (chest.locked && user.player.equipment.hasKey()) {
            user.player.useKey();
            user.player.update();
            chest.unlock();
          }

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return ChestLootDialog(
                  chest: chest,
                );
              });
        },
        child: SizedBox(
          height: chest.size,
          width: chest.size,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  AppImages().getChestSprite(chest.name, chest.lootIsEmpty()),
                  height: chest.size,
                  width: chest.size,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
