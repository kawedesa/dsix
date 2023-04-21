import 'package:dsix/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

class AuraSprite extends StatelessWidget {
  final List<String> auras;
  const AuraSprite({super.key, required this.auras});

  @override
  Widget build(BuildContext context) {
    return (auras.isEmpty)
        ? const SizedBox()
        : Align(
            alignment: Alignment.center,
            child: TransparentPointer(
              transparent: true,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.uiColorDark.withAlpha(15),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.uiColorDark.withAlpha(50),
                    width: 0.3,
                  ),
                ),
              ),
            ),
          );
  }
}
