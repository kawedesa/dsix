import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpriteEffects extends StatelessWidget {
  final Effect effect;
  const SpriteEffects({super.key, required this.effect});

  @override
  Widget build(BuildContext context) {
    int displayNumber = 0;

    switch (effect.name) {
      case 'poison':
        displayNumber = effect.countdown;
        break;
      case 'bleed':
        displayNumber = effect.countdown;
        break;
      case 'tempArmor':
        displayNumber = effect.value;
        break;
      case 'tempVision':
        displayNumber = 0;
        break;
    }

    return SizedBox(
      width: 3,
      height: 3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages().getEffectIcon(effect.name),
              color: AppColors().getEffectColor(effect.name),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.1),
            child:
                AppEffectsText(value: displayNumber, effectName: effect.name),
          ),
        ],
      ),
    );
  }
}

class AppEffectsText extends StatelessWidget {
  final String effectName;
  final int value;

  const AppEffectsText(
      {super.key, required this.effectName, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text(
      (value == 0) ? '' : value.toString(),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 1.0,
        letterSpacing: 0.01,
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
        color: Colors.white,
      ),
    );
  }
}
