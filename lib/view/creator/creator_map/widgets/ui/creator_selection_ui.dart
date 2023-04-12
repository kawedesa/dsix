import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/map/ui/life_bar.dart';
import 'package:dsix/shared/app_widgets/map/map_circular_button.dart';
import 'package:dsix/shared/app_widgets/map/ui/map_text.dart';
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
      child: Stack(
        children: [
          (user.npc == null)
              ? const SizedBox()
              : Align(
                  alignment: const Alignment(0.0, -0.9),
                  child: Container(
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
                            child: MapText(
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
                ),
          (user.building == null)
              ? const SizedBox()
              : Align(
                  alignment: const Alignment(0.0, -0.9),
                  child: Container(
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
                            child: MapText(
                              text: user.building!.name.toUpperCase(),
                              fontSize: 18,
                              isBold: false,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: LifeBar(
                              life: user.building!.life,
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
                ),
        ],
      ),
    );
  }
}
