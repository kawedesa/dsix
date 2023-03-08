import 'package:flutter/material.dart';

class AppColors {
//UI

  static const uiColor = Color.fromARGB(255, 158, 158, 158);
  static const uiColorLight = Color.fromARGB(255, 206, 206, 206);
  static const uiColorDark = Color.fromARGB(255, 50, 50, 50);
  static const positive = Color.fromARGB(255, 49, 145, 46);
  static const negative = Color.fromARGB(255, 193, 23, 8);
  static const selected = Color.fromARGB(255, 49, 198, 44);
  static const cancel = Color.fromARGB(255, 193, 23, 8);

//EFFECTS

  static const poison = Color.fromARGB(255, 83, 117, 20);
  static const positiveEffects = Color.fromARGB(255, 34, 32, 32);
  static const negativeEffects = Color.fromARGB(255, 124, 24, 13);

  Color getEffectColor(String effect) {
    Color color = uiColor;

    switch (effect) {
      case 'tempVision':
        color = positiveEffects;
        break;
      case 'tempArmor':
        color = positiveEffects;
        break;
      case 'poison':
        color = poison;
        break;
      case 'bleed':
        color = negativeEffects;
        break;
    }
    return color;
  }

//PLAYERS
//Pink

  static const pink = Color.fromRGBO(255, 64, 129, 1);
  static const pinkLight = Color.fromRGBO(248, 187, 208, 1);
  static const pinkDark = Color.fromARGB(255, 165, 9, 58);

  static const pinkSpriteShadow = Color.fromRGBO(176, 47, 103, 1);

//Blue

  static const blue = Color.fromRGBO(83, 109, 254, 1);
  static const blueLight = Color.fromRGBO(197, 202, 233, 1);
  static const blueDark = Color.fromRGBO(40, 53, 147, 1);

  static const blueSpriteShadow = Color.fromRGBO(16, 102, 121, 1);

//Green

  static const green = Color.fromRGBO(0, 150, 136, 1);
  static const greenLight = Color.fromRGBO(178, 223, 219, 1);
  static const greenDark = Color.fromARGB(255, 0, 77, 68);

  static const greenSpriteShadow = Color.fromRGBO(73, 133, 22, 1);

//Yellow

  static const yellow = Color.fromRGBO(255, 169, 0, 1);
  static const yellowLight = Color.fromRGBO(255, 224, 178, 1);
  static const yellowDark = Color.fromARGB(255, 161, 94, 0);

  static const yellowSpriteShadow = Color.fromRGBO(187, 136, 0, 1);

//Purple

  static const purple = Color.fromRGBO(156, 39, 176, 1);
  static const purpleLight = Color.fromRGBO(225, 190, 231, 1);
  static const purpleDark = Color.fromARGB(255, 90, 9, 102);

  static const purpleSpriteShadow = Color.fromRGBO(118, 53, 144, 1);

  Color getPlayerColor(String id) {
    Color color = uiColor;

    switch (id) {
      case 'blue':
        color = blue;
        break;
      case 'pink':
        color = pink;
        break;
      case 'green':
        color = green;
        break;
      case 'yellow':
        color = yellow;
        break;
      case 'purple':
        color = purple;
        break;
    }
    return color;
  }

  Color getPlayerDarkColor(String id) {
    Color color = uiColorDark;

    switch (id) {
      case 'blue':
        color = blueDark;
        break;
      case 'pink':
        color = pinkDark;
        break;
      case 'green':
        color = greenDark;
        break;
      case 'yellow':
        color = yellowDark;
        break;
      case 'purple':
        color = purpleDark;
        break;
    }
    return color;
  }

  Color getPlayerLightColor(String id) {
    Color color = uiColorLight;

    switch (id) {
      case 'blue':
        color = blueLight;
        break;
      case 'pink':
        color = pinkLight;
        break;
      case 'green':
        color = greenLight;
        break;
      case 'yellow':
        color = yellowLight;
        break;
      case 'purple':
        color = purpleLight;
        break;
    }
    return color;
  }
}
