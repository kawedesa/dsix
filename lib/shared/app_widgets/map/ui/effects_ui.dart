import 'package:dsix/model/combat/effect/effect.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EffectsUi extends StatelessWidget {
  final List<Effect> effects;
  final int tempArmor;
  final int tempVision;
  const EffectsUi(
      {super.key,
      required this.effects,
      required this.tempArmor,
      required this.tempVision});

  @override
  Widget build(BuildContext context) {
    List<Widget> effectsIcons = [];

    if (tempArmor != 0) {
      effectsIcons.add(SpriteEffects(
          effect: Effect(
        name: 'tempArmor',
        description: '',
        value: tempArmor,
        countdown: 0,
      )));
    }
    if (tempVision != 0) {
      effectsIcons.add(SpriteEffects(
          effect: Effect(
        name: 'tempVision',
        description: '',
        value: tempVision,
        countdown: 0,
      )));
    }
    for (Effect effect in effects) {
      effectsIcons.add(SpriteEffects(effect: effect));
    }

    return SizedBox(
      width: 3.1 * effectsIcons.length,
      height: 3.1 * effectsIcons.length,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: effectsIcons,
      ),
    );
  }
}

class SpriteEffects extends StatelessWidget {
  final Effect effect;
  const SpriteEffects({super.key, required this.effect});
  int getDisplayValue() {
    int displayNumber = 0;
    switch (effect.name) {
      case 'poison':
        displayNumber = effect.countdown;
        break;
      case 'burn':
        displayNumber = effect.countdown;
        break;
      case 'bleed':
        displayNumber = effect.countdown;
        break;
      case 'vulnerable':
        displayNumber = effect.countdown;
        break;
      case 'stun':
        displayNumber = effect.countdown;
        break;
      case 'weaken':
        displayNumber = effect.countdown;
        break;
      case 'tempArmor':
        displayNumber = effect.value;
        break;
      case 'tempVision':
        displayNumber = 0;
        break;
    }
    return displayNumber;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 3,
      height: 3,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages().getEffectIcon(effect.name),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.1),
            child: AppEffectsText(
                value: getDisplayValue(), effectName: effect.name),
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
