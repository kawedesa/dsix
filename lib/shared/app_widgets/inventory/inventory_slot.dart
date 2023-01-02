import 'package:dsix/model/player/equipment/equipment_slot.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InventorySlot extends StatefulWidget {
  final Color color;
  final String icon;
  final EquipmentSlot equipmentSlot;

  final bool Function(EquipmentSlot) onWillAccept;
  final Function(EquipmentSlot) onAccept;
  final Function() onDragComplete;

  const InventorySlot({
    super.key,
    required this.color,
    required this.icon,
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
          return Draggable<EquipmentSlot>(
            data: widget.equipmentSlot,
            feedback: AppCircularButton(
              size: 0.12,
              color: widget.color,
              borderColor: widget.color,
              icon: widget.equipmentSlot.item.icon,
              iconColor: Colors.black,
            ),
            onDragCompleted: () => widget.onDragComplete(),
            child: Container(
              width: AppLayout.avarage(context) * 0.12,
              height: AppLayout.avarage(context) * 0.12,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: widget.color,
                  width: AppLayout.shortest(context) * 0.005,
                ),
              ),
              child: Expanded(
                child: (widget.equipmentSlot.item.name == '')
                    ? SvgPicture.asset(
                        widget.icon,
                        color: widget.color,
                      )
                    : SvgPicture.asset(
                        widget.equipmentSlot.item.icon,
                        color: Colors.white,
                      ),
              ),
            ),
          );
        });
  }
}
