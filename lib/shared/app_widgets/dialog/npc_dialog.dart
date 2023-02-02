import 'package:dsix/model/npc/npc.dart';
import 'package:dsix/model/npc/npc_list.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_widgets/button/app_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_line_divider_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_bar_title.dart';

import 'package:flutter/material.dart';

import '../../app_layout.dart';
import '../layout/app_line_divider_horizontal.dart';
import '../layout/app_separator_vertical.dart';
import 'dialog_button.dart';
import 'dialog_title.dart';

class NpcDialog extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final Function(Npc) chooseNpc;
  const NpcDialog({
    super.key,
    required this.color,
    required this.darkColor,
    required this.chooseNpc,
  });

  @override
  State<NpcDialog> createState() => _NpcDialogState();
}

class _NpcDialogState extends State<NpcDialog> {
  Npc? selectedNpc;

  @override
  Widget build(BuildContext context) {
    selectedNpc ??= NpcList().getNpcList().first;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.shortest(context) * 0.6,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.color,
            width: AppLayout.shortest(context) * 0.005,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: widget.color,
              title: 'npc',
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppSeparatorVertical(value: 0.025),
                  SizedBox(
                    width: AppLayout.shortest(context) * 0.55,
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      crossAxisCount: 6,
                      // crossAxisCount:
                      //     (AppLayout.avarage(context) * 0.006).toInt(),
                      mainAxisSpacing: AppLayout.height(context) * 0.01,
                      crossAxisSpacing: AppLayout.width(context) * 0.01,
                      children:
                          List.generate(NpcList().getNpcList().length, (index) {
                        return GestureDetector(
                          onTap: () {},
                          child: (selectedNpc!.race ==
                                  NpcList().getNpcList()[index].race)
                              ? AppCircularButton(
                                  color: widget.color,
                                  borderColor: widget.color,
                                  iconColor: widget.darkColor,
                                  icon: AppImages().getRaceIcon(
                                      NpcList().getNpcList()[index].race),
                                  size: 0.07,
                                  onTap: () {
                                    setState(() {
                                      selectedNpc =
                                          NpcList().getNpcList()[index];
                                    });
                                  },
                                )
                              : AppCircularButton(
                                  color: widget.darkColor,
                                  borderColor: widget.color,
                                  iconColor: widget.color,
                                  icon: AppImages().getRaceIcon(
                                      NpcList().getNpcList()[index].race),
                                  size: 0.07,
                                  onTap: () {
                                    setState(() {
                                      selectedNpc =
                                          NpcList().getNpcList()[index];
                                    });
                                  },
                                ),
                        );
                      }),
                    ),
                  ),
                  const AppSeparatorVertical(value: 0.025),
                  AppLineDividerHorizontal(color: widget.color, value: 5),
                  SizedBox(
                    height: AppLayout.height(context) * 0.35,
                    child: Row(
                      children: [
                        const Expanded(flex: 2, child: SizedBox()),
                        AppLineDividerVertical(color: widget.color, value: 2.5),
                        Expanded(
                            flex: 3,
                            child: SizedBox(
                              child: Column(
                                children: [
                                  const AppSeparatorVertical(value: 0.025),
                                  AppBarTitle(
                                      title: selectedNpc!.race,
                                      color: widget.color),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DialogButton(
                color: widget.color,
                buttonText: 'choose',
                onTap: () {
                  widget.chooseNpc(selectedNpc!);
                  Navigator.pop(context);
                }),
          ],
        ),
      ),
    );
  }
}
