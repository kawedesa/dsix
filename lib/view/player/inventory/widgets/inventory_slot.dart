import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/dialog/item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventorySlot extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final String icon;
  final EquipmentSlot equipmentSlot;
  final bool Function(EquipmentSlot) onWillAccept;
  final Function(EquipmentSlot) onAccept;
  final Function() onDragComplete;
  final Function() sellItem;
  final Function() useItem;

  const InventorySlot({
    super.key,
    required this.color,
    required this.darkColor,
    required this.icon,
    required this.equipmentSlot,
    required this.onWillAccept,
    required this.onAccept,
    required this.onDragComplete,
    required this.sellItem,
    required this.useItem,
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
            width: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height)
                ? AppLayout.avarage(context) * 0.12
                : AppLayout.shortest(context) * 0.12,
            height: (MediaQuery.of(context).size.width <
                    MediaQuery.of(context).size.height)
                ? AppLayout.avarage(context) * 0.12
                : AppLayout.shortest(context) * 0.12,
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
                              widget.sellItem();
                            },
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Draggable<EquipmentSlot>(
                        data: widget.equipmentSlot,
                        feedback: SizedBox(
                          width: AppLayout.shortest(context) * 0.15,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: AppCircularButton(
                              size: 0.15,
                              color: widget.color,
                              borderColor: widget.color,
                              icon: AppImages()
                                  .getItemIcon(widget.equipmentSlot.item.name),
                              iconColor: Colors.white,
                            ),
                          ),
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
