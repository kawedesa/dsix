import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/item_detail.dart';
import 'package:dsix/model/user/user.dart';
import 'package:dsix/shared/app_exceptions.dart';
import 'package:dsix/shared/app_globals.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/app_snackbar.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../shared/images/app_images.dart';
import '../../shared/shared_widgets/button/app_circular_button.dart';

class ItemDialog extends StatelessWidget {
  final Color color;
  final Color darkColor;
  final Item item;
  final bool displayOnly;

  const ItemDialog({
    super.key,
    required this.color,
    required this.darkColor,
    required this.item,
    required this.displayOnly,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.35,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: color,
            width: AppLayout.avarage(context) * 0.004,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                DialogTitle(
                  color: color,
                  title: (item.enchanted) ? 'magic ${item.name}' : item.name,
                  subTitle: item.itemSlot,
                ),
                (displayOnly)
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.topRight,
                        child: AppCircularButton(
                            icon: AppImages.cancel,
                            iconColor: user.darkColor,
                            color: user.color,
                            borderColor: user.darkColor,
                            borderSize: 3,
                            size: 0.025,
                            onTap: () {
                              user.player.deleteItem(item);
                              user.player.update();
                              Navigator.pop(context);
                            })),
                (displayOnly)
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.topLeft,
                        child: AppCircularButton(
                            icon: AppImages.money,
                            iconSize: 0.65,
                            iconColor: user.darkColor,
                            color: user.color,
                            borderColor: user.darkColor,
                            borderSize: 3,
                            size: 0.025,
                            onTap: () {
                              try {
                                Navigator.pop(context);
                                user.player.sellItem(item);
                                user.player.update();
                              } on ItemSoldException catch (e) {
                                snackbarKey.currentState?.showSnackBar(
                                    AppSnackBar().getSnackBar(
                                        e.itemValue.toUpperCase(), user.color));
                              }
                            }),
                      ),
              ],
            ),
            Container(
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          AppImages().getItemIcon(item.name),
                          width: AppLayout.avarage(context) * 0.35,
                          height: AppLayout.avarage(context) * 0.35,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: ItemDetail(
                              item: item, color: color, darkColor: darkColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            (item.itemSlot == 'consumable' && displayOnly == false)
                ? DialogButton(
                    color: color,
                    buttonText: 'use',
                    onTap: () {
                      user.player.useItem(item);
                      user.player.update();
                      Navigator.pop(context);
                    })
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
