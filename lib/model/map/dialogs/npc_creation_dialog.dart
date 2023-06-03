import 'package:dsix/model/attributes/attributes_info_bar.dart';
import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/npc/npc_list.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/shared_widgets/text/app_text.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/button/app_text_button.dart';
import 'package:dsix/shared/shared_widgets/layout/app_line_divider_horizontal.dart';
import 'package:dsix/shared/images/npc_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NpcCreationDialog extends StatefulWidget {
  const NpcCreationDialog({
    super.key,
  });

  @override
  State<NpcCreationDialog> createState() => _NpcCreationDialogState();
}

class _NpcCreationDialogState extends State<NpcCreationDialog> {
  Npc? selectedNpc;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    selectedNpc ??= NpcList().getNpcList().first;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        decoration: BoxDecoration(
          color: AppColors.uiColor,
          border: Border.all(
            color: AppColors.uiColor,
            width: AppLayout.avarage(context) * 0.0025,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: AppLayout.avarage(context) * 0.4,
              height: AppLayout.avarage(context) * 0.4,
              child: Container(
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: AppLayout.avarage(context) * 0.4,
                        color: AppColors.uiColor,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: List.generate(NpcList().getNpcList().length,
                              (index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedNpc =
                                          NpcList().getNpcList()[index];
                                    });
                                  },
                                  child: Container(
                                    color: (selectedNpc!.name ==
                                            NpcList().getNpcList()[index].name)
                                        ? AppColors.uiColorLight
                                        : AppColors.uiColor,
                                    width: double.infinity,
                                    height: AppLayout.avarage(context) * 0.04,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          AppText(
                                            text: NpcList()
                                                .getNpcList()[index]
                                                .name
                                                .toUpperCase(),
                                            fontSize: 0.008,
                                            letterSpacing: 0.0002,
                                            color: (selectedNpc!.name ==
                                                    NpcList()
                                                        .getNpcList()[index]
                                                        .name)
                                                ? AppColors.uiColor
                                                : Colors.black,
                                          ),
                                          AppText(
                                            text:
                                                'xp: ${NpcList().getNpcList()[index].xp}'
                                                    .toUpperCase(),
                                            fontSize: 0.007,
                                            letterSpacing: 0.0002,
                                            bold: true,
                                            color: (selectedNpc!.name ==
                                                    NpcList()
                                                        .getNpcList()[index]
                                                        .name)
                                                ? AppColors.uiColor
                                                : Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const AppLineDividerHorizontal(
                                    color: Colors.black, value: 2),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AppLayout.avarage(context) * 0.3,
                      height: AppLayout.avarage(context) * 0.4,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                              bold: true,
                              text: selectedNpc!.name.toUpperCase(),
                              fontSize: 0.025,
                              letterSpacing: 0.002,
                              color: AppColors.uiColor),
                          NpcImage(
                            name: selectedNpc!.name,
                            size: AppLayout.avarage(context) * 0.2,
                          ),
                          AttributesInfoBar(
                              size: 0.25,
                              color: AppColors.uiColor,
                              darkColor: AppColors.uiColorDark,
                              attributes: selectedNpc!.attributes),
                          AppTextButton(
                              color: AppColors.uiColor,
                              buttonText: 'choose',
                              onTap: () {
                                selectedNpc!.setId();
                                selectedNpc!.resetPosition();
                                user.startPlacingSomething('npc');
                                user.deselect();
                                user.selectNpc(selectedNpc!);
                                Navigator.pop(context);
                              }),
                        ],
                      )),
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
