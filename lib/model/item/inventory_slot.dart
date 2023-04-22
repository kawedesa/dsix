import 'package:dsix/model/item/equipment_slot.dart';
import 'package:dsix/model/player/player.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventorySlot extends StatelessWidget {
  final Color color;
  final Color darkColor;
  final String icon;
  final Player player;
  final EquipmentSlot equipmentSlot;
  final bool Function(EquipmentSlot) onWillAccept;
  final Function(EquipmentSlot) onAccept;
  final Function() onDragComplete;
  final Function() onTap;
  final Function() onDoubleTap;

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
    required this.onTap,
    required this.onDoubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<EquipmentSlot>(
        onWillAccept: (equipment) => onWillAccept(equipment!),
        onAccept: (equipment) => onAccept(equipment),
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
                color: color,
                width: AppLayout.shortest(context) * 0.005,
              ),
            ),
            child: (equipmentSlot.item.name == 'empty')
                ? SvgPicture.asset(
                    icon,
                    color: color,
                  )
                : GestureDetector(
                    onTap: () => onTap(),
                    onDoubleTap: () => onDoubleTap(),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Draggable<EquipmentSlot>(
                        data: equipmentSlot,
                        feedback: AppCircularButton(
                          size: 0.06,
                          iconSize: 1,
                          color: color.withAlpha(155),
                          borderColor: color,
                          icon:
                              AppImages().getItemIcon(equipmentSlot.item.name),
                          iconColor: Colors.white,
                        ),
                        onDragCompleted: () => onDragComplete(),
                        childWhenDragging: SvgPicture.asset(
                          AppImages().getItemIcon(equipmentSlot.item.name),
                          color: color.withAlpha(155),
                        ),
                        child: SvgPicture.asset(
                          AppImages().getItemIcon(equipmentSlot.item.name),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
          );
        });
  }
}
