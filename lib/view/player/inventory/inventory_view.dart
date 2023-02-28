import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/map/sprite/player_sprite_image.dart';
import 'package:dsix/view/player/inventory/inventory_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatefulWidget {
  final Function() refresh;
  final Function(String, Color) displaySnackbar;
  const InventoryView(
      {Key? key, required this.refresh, required this.displaySnackbar})
      : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final InventoryVM _inventoryVM = InventoryVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _inventoryVM.setInventorySlots(
        user, widget.refresh, widget.displaySnackbar);
    _inventoryVM.setBagSlots(user, widget.refresh, widget.displaySnackbar);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppSeparatorVertical(
          value: 0.02,
        ),
        SizedBox(
          width: AppLayout.shortest(context) * 0.8,
          height: AppLayout.height(context) * 0.06,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // Row(
              //   children: [
              //     AppCircularButton(
              //         icon: AppImages.pDamage,
              //         iconColor: user.darkColor,
              //         color: user.color,
              //         borderColor: user.color,
              //         size: 0.075),
              //     const AppSeparatorHorizontal(value: 0.025),
              //     AppText(
              //         text: user.player.equipment.damage.pDamage.toString(),
              //         fontSize: 0.04,
              //         letterSpacing: 0.002,
              //         color: Colors.white),
              //   ],
              // ),
              // Row(
              //   children: [
              //     AppCircularButton(
              //         icon: AppImages.pArmor,
              //         iconColor: user.darkColor,
              //         color: user.color,
              //         borderColor: user.color,
              //         size: 0.075),
              //     const AppSeparatorHorizontal(value: 0.025),
              //     AppText(
              //         text: user.player.equipment.armor.pArmor.toString(),
              //         fontSize: 0.04,
              //         letterSpacing: 0.002,
              //         color: Colors.white),
              //   ],
              // ),
              // Row(
              //   children: [
              //     AppCircularButton(
              //         icon: AppImages.mDamage,
              //         iconColor: user.darkColor,
              //         color: user.color,
              //         borderColor: user.color,
              //         size: 0.075),
              //     const AppSeparatorHorizontal(value: 0.025),
              //     AppText(
              //         text: user.player.equipment.damage.mDamage.toString(),
              //         fontSize: 0.04,
              //         letterSpacing: 0.002,
              //         color: Colors.white),
              //   ],
              // ),
              // Row(
              //   children: [
              //     AppCircularButton(
              //         icon: AppImages.mArmor,
              //         iconColor: user.darkColor,
              //         color: user.color,
              //         borderColor: user.color,
              //         size: 0.075),
              //     const AppSeparatorHorizontal(value: 0.025),
              //     AppText(
              //         text: user.player.equipment.armor.mArmor.toString(),
              //         fontSize: 0.04,
              //         letterSpacing: 0.002,
              //         color: Colors.white),
              //   ],
              // ),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 4),
        const AppSeparatorVertical(value: 0.025),
        Column(
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height)
                  ? AppLayout.avarage(context) * 0.5
                  : AppLayout.shortest(context) * 0.5,
              height: (MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height)
                  ? AppLayout.avarage(context) * 0.45
                  : AppLayout.shortest(context) * 0.45,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _inventoryVM.headSlot!,
                        _inventoryVM.bodySlot!,
                        _inventoryVM.handSlot!,
                        _inventoryVM.feetSlot!,
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                          height: (MediaQuery.of(context).size.width <
                                  MediaQuery.of(context).size.height)
                              ? AppLayout.avarage(context) * 0.35
                              : AppLayout.shortest(context) * 0.35,
                          child: PlayerSpriteImage(
                              isDead: user.player.life.isDead(),
                              color: user.color,
                              race: user.player.race))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _inventoryVM.mainHandSlot!,
                        const AppSeparatorHorizontal(value: 0.1),
                        _inventoryVM.offHandSlot!,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const AppSeparatorVertical(value: 0.025),
            SizedBox(
              width: (MediaQuery.of(context).size.width <
                      MediaQuery.of(context).size.height)
                  ? AppLayout.avarage(context) * 0.5
                  : AppLayout.shortest(context) * 0.5,
              child: _inventoryVM.bagSlot,
            ),
          ],
        )
        // Expanded(
        //   child: Stack(
        //     children: [
        //       Align(
        //         alignment:
        //             Alignment(0.0, -0.5 - (AppLayout.width(context) * 0.0005)),
        //         child:
        //       ),
        //       Align(
        //         alignment: Alignment.bottomCenter,
        //         child: _inventoryVM.bagSlot,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
