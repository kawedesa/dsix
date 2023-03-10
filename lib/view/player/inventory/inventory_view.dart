import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';

import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/map/player_sprite_image.dart';

import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:dsix/view/player/inventory/inventory_vm.dart';
import 'package:dsix/view/player/inventory/widgets/attributes_info_bar.dart';
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
          value: 0.01,
        ),
        AttributesInfoBar(
          color: user.color,
          darkColor: user.darkColor,
          attributes: user.player.attributes,
        ),
        const AppSeparatorVertical(
          value: 0.01,
        ),
        AppLineDividerHorizontal(color: user.color, value: 4),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: AppLayout.avarage(context) * 0.5,
              height: AppLayout.avarage(context) * 0.5,
              child: Stack(
                children: [
                  Align(
                    alignment: const Alignment(0, -0.4),
                    child: SizedBox(
                        height: AppLayout.avarage(context) * 0.25,
                        child: PlayerSpriteImage(
                            isDead: user.player.life.isDead(),
                            color: user.color,
                            race: user.player.race)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _inventoryVM.headSlot!,
                          _inventoryVM.bodySlot!,
                          _inventoryVM.handSlot!,
                          _inventoryVM.feetSlot!,
                        ],
                      ),
                      const AppSeparatorVertical(value: 0.035),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AppCircularButton(
                                  icon: AppImages.pArmor,
                                  iconColor: user.darkColor,
                                  color: user.color,
                                  borderColor: user.color,
                                  size: 0.04),
                              const AppSeparatorHorizontal(value: 0.015),
                              AppText(
                                  text: user.player.equipment
                                      .getPArmor()
                                      .toString(),
                                  fontSize: 0.015,
                                  letterSpacing: 0.001,
                                  color: Colors.white),
                            ],
                          ),
                          Row(
                            children: [
                              AppText(
                                  text: user.player.equipment
                                      .getMArmor()
                                      .toString(),
                                  fontSize: 0.015,
                                  letterSpacing: 0.001,
                                  color: Colors.white),
                              const AppSeparatorHorizontal(value: 0.015),
                              AppCircularButton(
                                  icon: AppImages.mArmor,
                                  iconColor: user.darkColor,
                                  color: user.color,
                                  borderColor: user.color,
                                  size: 0.04),
                            ],
                          )
                        ],
                      ),
                      const AppSeparatorVertical(value: 0.035),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _inventoryVM.mainHandSlot!,
                          _inventoryVM.offHandSlot!,
                        ],
                      ),
                      const AppSeparatorVertical(value: 0.025),
                      SizedBox(
                        width: AppLayout.avarage(context) * 0.5,
                        child: _inventoryVM.bagSlot,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
