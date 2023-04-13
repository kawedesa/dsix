import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_snackbar.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventorySlot extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final String icon;
  final Player player;
  final EquipmentSlot equipmentSlot;
  final bool Function(EquipmentSlot) onWillAccept;
  final Function(EquipmentSlot) onAccept;
  final Function() onDragComplete;

  const InventorySlot({
    super.key,
    required this.color,
    required this.darkColor,
    required this.icon,
    required this.player,
    required this.equipmentSlot,
    required this.onWillAccept,
    required this.onAccept,
    required this.onDragComplete,
  });

  @override
  State<InventorySlot> createState() => _InventorySlotState();
}

class _InventorySlotState extends State<InventorySlot> {
  @override
  Widget build(BuildContext context) {
    return DragTarget<EquipmentSlot>(
        onWillAccept: (equipment) => widget.onWillAccept(equipment!),
        onAccept: (equipment) => widget.onAccept(equipment),
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return Container(
            width: AppLayout.avarage(context) * 0.09,
            height: AppLayout.avarage(context) * 0.09,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: widget.color,
                width: AppLayout.shortest(context) * 0.005,
              ),
            ),
            child: (widget.equipmentSlot.item.name == 'empty')
                ? SvgPicture.asset(
                    widget.icon,
                    color: widget.color,
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ItemDialog(
                            color: widget.color,
                            darkColor: widget.darkColor,
                            item: widget.equipmentSlot.item,
                            sellItem: () {
                              try {
                                widget.player.sellItem(
                                    widget.player.equipment.mainHandSlot);
                              } on ItemSoldException catch (e) {
                                snackbarKey.currentState?.showSnackBar(
                                    AppSnackBar().getSnackBar(
                                        e.itemValue.toUpperCase(),
                                        widget.color));
                              }
                            },
                          );
                        },
                      );
                    },
                    onDoubleTap: () {
                      widget.player.quickEquip(widget.equipmentSlot);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Draggable<EquipmentSlot>(
                        data: widget.equipmentSlot,
                        feedback: AppCircularButton(
                          size: 0.06,
                          iconSize: 1,
                          color: widget.color.withAlpha(155),
                          borderColor: widget.color,
                          icon: AppImages()
                              .getItemIcon(widget.equipmentSlot.item.name),
                          iconColor: Colors.white,
                        ),
                        onDragCompleted: () => widget.onDragComplete(),
                        childWhenDragging: SvgPicture.asset(
                          AppImages()
                              .getItemIcon(widget.equipmentSlot.item.name),
                          color: widget.color.withAlpha(155),
                        ),
                        child: SvgPicture.asset(
                          AppImages()
                              .getItemIcon(widget.equipmentSlot.item.name),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
