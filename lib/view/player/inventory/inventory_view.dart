import 'package:dsix/model/item/bag_slot.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/shared_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/images/player_image.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/view/player/inventory/inventory_vm.dart';
import 'package:dsix/model/attributes/attributes_info_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryView extends StatefulWidget {
  final Function() refresh;

  const InventoryView({Key? key, required this.refresh}) : super(key: key);

  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final InventoryVM _inventoryVM = InventoryVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    _inventoryVM.setInventorySlots(context, user, widget.refresh);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppSeparatorVertical(
          value: 0.01,
        ),
        AttributesInfoBar(
          size: 0.5,
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
                      child: PlayerImage(
                        race: user.player.race,
                        sex: user.player.sex,
                        size: AppLayout.avarage(context) * 0.25,
                        headMovement: AppLayout.avarage(context) * 0.002,
                        color: Colors.transparent,
                      )),
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
                        child: BagSlot(
                          displayOnly: false,
                          refresh: () => widget.refresh(),
                        ),
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
