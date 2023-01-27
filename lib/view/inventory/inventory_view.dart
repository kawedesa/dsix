import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/player/player_sprite.dart';
import 'package:dsix/shared/app_widgets/text/app_text.dart';
import 'package:dsix/view/inventory/inventory_vm.dart';
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
            children: [
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.damage.pDamage.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.pArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.armor.pArmor.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mDamage,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.damage.mDamage.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
              Row(
                children: [
                  AppCircularButton(
                      icon: AppImages.mArmor,
                      iconColor: user.darkColor,
                      color: user.color,
                      borderColor: user.color,
                      size: 0.075),
                  const AppSeparatorHorizontal(value: 0.025),
                  AppText(
                      text: user.player!.equipment.armor.mArmor.toString(),
                      fontSize: 0.04,
                      letterSpacing: 0.002,
                      color: Colors.white),
                ],
              ),
            ],
          ),
        ),
        const AppSeparatorVertical(
          value: 0.02,
        ),
        AppLineDividerHorizontal(color: user.color, value: 4),
        Expanded(
          child: Stack(
            children: [
              (AppLayout.width(context) > AppLayout.height(context) * 0.55)
                  ? Align(
                      alignment: const Alignment(0.0, -0.75),
                      child: SizedBox(
                        width: AppLayout.width(context) * 0.9,
                        height: AppLayout.height(context) * 0.45,
                        child: (AppLayout.width(context) >
                                AppLayout.height(context) * 1.25)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: AppLayout.avarage(context) * 0.25,
                                    height: AppLayout.avarage(context) * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _inventoryVM.mainHandSlot!,
                                            _inventoryVM.headSlot!,
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _inventoryVM.handSlot!,
                                            Container(
                                              width:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              height:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: user.color,
                                                  width: AppLayout.shortest(
                                                          context) *
                                                      0.005,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  PlayerSprite(race: user.player!.race),
                                  SizedBox(
                                    width: AppLayout.avarage(context) * 0.25,
                                    height: AppLayout.avarage(context) * 0.25,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            _inventoryVM.bodySlot!,
                                            _inventoryVM.offHandSlot!,
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              height:
                                                  AppLayout.avarage(context) *
                                                      0.12,
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                border: Border.all(
                                                  color: user.color,
                                                  width: AppLayout.shortest(
                                                          context) *
                                                      0.005,
                                                ),
                                              ),
                                            ),
                                            _inventoryVM.feetSlot!,
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _inventoryVM.headSlot!,
                                      _inventoryVM.mainHandSlot!,
                                      _inventoryVM.handSlot!,
                                      Container(
                                        width:
                                            AppLayout.avarage(context) * 0.12,
                                        height:
                                            AppLayout.avarage(context) * 0.12,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: user.color,
                                            width: AppLayout.shortest(context) *
                                                0.005,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  PlayerSprite(race: user.player!.race),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _inventoryVM.bodySlot!,
                                      _inventoryVM.offHandSlot!,
                                      _inventoryVM.feetSlot!,
                                      Container(
                                        width:
                                            AppLayout.avarage(context) * 0.12,
                                        height:
                                            AppLayout.avarage(context) * 0.12,
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: user.color,
                                            width: AppLayout.shortest(context) *
                                                0.005,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    )
                  : Align(
                      alignment: Alignment(
                          0.0, -0.5 - (AppLayout.width(context) * 0.0005)),
                      child: SizedBox(
                        width: AppLayout.shortest(context) * 0.9,
                        height: AppLayout.avarage(context) * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _inventoryVM.mainHandSlot!,
                                _inventoryVM.headSlot!,
                                _inventoryVM.bodySlot!,
                                _inventoryVM.offHandSlot!,
                              ],
                            ),
                            PlayerSprite(race: user.player!.race),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _inventoryVM.handSlot!,
                                Container(
                                  width: AppLayout.avarage(context) * 0.12,
                                  height: AppLayout.avarage(context) * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: user.color,
                                      width:
                                          AppLayout.shortest(context) * 0.005,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: AppLayout.avarage(context) * 0.12,
                                  height: AppLayout.avarage(context) * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: user.color,
                                      width:
                                          AppLayout.shortest(context) * 0.005,
                                    ),
                                  ),
                                ),
                                _inventoryVM.feetSlot!,
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: _inventoryVM.bagSlot,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
