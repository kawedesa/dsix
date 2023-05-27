import 'package:dsix/shared/images/action_area_image.dart';
import 'package:flutter/material.dart';

class ActionAreaSprite extends StatelessWidget {
  final ValueNotifier<Path> actionArea;
  const ActionAreaSprite({Key? key, required this.actionArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Path>(
      valueListenable: actionArea,
      builder: (context, position, child) {
        return CustomPaint(
          painter: ActionAreaImage(
            area: actionArea.value,
          ),
        );
      },
    );
  }
}
