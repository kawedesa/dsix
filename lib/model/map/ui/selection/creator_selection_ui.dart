import 'package:dsix/model/map/ui/effects_ui.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/images/app_images.dart';
import 'package:dsix/model/map/ui/selection/life_bar.dart';
import 'package:dsix/model/map/buttons/map_circular_button.dart';
import 'package:dsix/model/map/ui/selection/selection_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreatorSelectionUi extends StatelessWidget {
  const CreatorSelectionUi({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Align(
        alignment: const Alignment(0.0, -0.9),
        child: Stack(
          children: [
            (user.npc == null)
                ? const SizedBox()
                : SizedBox(
                    width: 300,
                    height: 105,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 300,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(150),
                            border: Border.all(
                              color: Colors.black.withAlpha(150),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: SelectionText(
                                    text: user.npc!.name.toUpperCase(),
                                    fontSize: 18,
                                    isBold: false,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: LifeBar(
                                    life: user.npc!.life,
                                    width: 260,
                                    height: 12,
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: MapCircularButton(
                                        icon: AppImages.cancel,
                                        iconColor: Colors.black,
                                        color: AppColors.delete,
                                        borderColor: AppColors.delete,
                                        borderSize: 3,
                                        size: 20.0,
                                        onTap: () {
                                          user.npc!.delete();
                                          user.deselect();
                                        })),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: MapCircularButton(
                                      icon: AppImages.plus,
                                      iconSize: 0.65,
                                      iconColor: Colors.white,
                                      color: Colors.black,
                                      borderColor: Colors.black,
                                      borderSize: 2,
                                      size: 20.0,
                                      onTap: () {
                                        user.duplicateNpc();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Transform.scale(
                            scale: 12,
                            child: EffectsUi(
                                effects: user.npc!.effects.currentEffects,
                                tempArmor:
                                    user.npc!.attributes.defense.tempArmor,
                                tempVision:
                                    user.npc!.attributes.vision.tempVision),
                          ),
                        ),
                      ],
                    ),
                  ),
            (user.building == null)
                ? const SizedBox()
                : Container(
                    width: 300,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      border: Border.all(
                        color: Colors.black.withAlpha(150),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SelectionText(
                              text: user.building!.name.toUpperCase(),
                              fontSize: 18,
                              isBold: false,
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: MapCircularButton(
                                  icon: AppImages.cancel,
                                  iconColor: Colors.black,
                                  color: AppColors.delete,
                                  borderColor: AppColors.delete,
                                  borderSize: 2,
                                  size: 20.0,
                                  onTap: () {
                                    user.building!.delete();
                                    user.deselect();
                                  })),
                          Align(
                            alignment: Alignment.topLeft,
                            child: MapCircularButton(
                                icon: AppImages.plus,
                                iconSize: 0.65,
                                iconColor: Colors.white,
                                color: Colors.black,
                                borderColor: Colors.black,
                                borderSize: 2,
                                size: 20.0,
                                onTap: () {
                                  user.duplicateBuilding();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
            (user.prop == null)
                ? const SizedBox()
                : Container(
                    width: 300,
                    height: 75,
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                      border: Border.all(
                        color: Colors.black.withAlpha(150),
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SelectionText(
                              text: user.prop!.name.toUpperCase(),
                              fontSize: 18,
                              isBold: false,
                            ),
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: MapCircularButton(
                                  icon: AppImages.cancel,
                                  iconColor: Colors.black,
                                  color: AppColors.delete,
                                  borderColor: AppColors.delete,
                                  borderSize: 2,
                                  size: 20.0,
                                  onTap: () {
                                    user.prop!.delete();
                                    user.deselect();
                                  })),
                          Align(
                            alignment: Alignment.topLeft,
                            child: MapCircularButton(
                                icon: AppImages.plus,
                                iconSize: 0.65,
                                iconColor: Colors.white,
                                color: Colors.black,
                                borderColor: Colors.black,
                                borderSize: 2,
                                size: 20.0,
                                onTap: () {
                                  user.duplicateProp();
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
