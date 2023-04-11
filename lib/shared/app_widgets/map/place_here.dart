import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';

class PlaceHere extends StatelessWidget {
  final Offset position;
  const PlaceHere({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 20,
      top: position.dy - 20,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.negative.withAlpha(50),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.negative.withAlpha(200),
            width: 3,
          ),
        ),
      ),
    );
  }
}
