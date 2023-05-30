import 'package:dsix/model/item/prop_loot_dialog.dart';
import 'package:dsix/model/map/sprites/hit_box_sprite.dart';
import 'package:dsix/model/prop/prop.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class PlayerViewPropSprite extends StatelessWidget {
  final Prop prop;

  const PlayerViewPropSprite({super.key, required this.prop});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Positioned(
      left: prop.position.dx - (prop.size / 2),
      top: prop.position.dy - (prop.size / 2),
      child: GestureDetector(
        child: SizedBox(
          width: prop.size,
          height: prop.size,
          child: Stack(
            children: [
              TransparentPointer(
                transparent: true,
                child: SvgPicture.asset(
                  AppImages()
                      .getPropSprite(prop.name, prop.type, prop.lootIsEmpty()),
                  height: prop.size,
                  width: prop.size,
                ),
              ),
              HitBoxSprite(
                size: prop.size,
                hitBox: prop.hitBox.propHitBox(prop.name, prop.type),
              ),
            ],
          ),
        ),
        onTap: () {
          if (user.player.position
                  .getDistanceFromPoint(prop.position.getOffset()) >
              12) {
            snackbarKey.currentState?.showSnackBar(
                AppSnackBar().getSnackBar('too far'.toUpperCase(), user.color));
            return;
          }

          if (prop.locked && user.player.equipment.hasKey() == false) {
            snackbarKey.currentState?.showSnackBar(AppSnackBar()
                .getSnackBar('you need a key'.toUpperCase(), user.color));
            return;
          }

          if (prop.locked && user.player.equipment.hasKey()) {
            user.player.useKey();
            user.player.update();
            prop.unlock();
          }

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return PropLootDialog(
                  id: prop.id,
                );
              });
        },
      ),
    );
  }
}