import 'package:dsix/model/item/item.dart';
import 'package:dsix/model/item/item_detail.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_button.dart';
import 'package:dsix/shared/shared_widgets/dialog/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../shared/images/app_images.dart';

class ShopDialog extends StatefulWidget {
  final Color color;
  final Color darkColor;
  final Item item;
  final Function() buyItem;
  const ShopDialog({
    super.key,
    required this.color,
    required this.darkColor,
    required this.item,
    required this.buyItem,
  });

  @override
  State<ShopDialog> createState() => _ShopDialogState();
}

class _ShopDialogState extends State<ShopDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      content: Container(
        width: AppLayout.avarage(context) * 0.35,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: widget.color,
            width: AppLayout.avarage(context) * 0.004,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DialogTitle(
              color: widget.color,
              title: widget.item.name,
              subTitle: widget.item.itemSlot,
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
                          AppImages().getItemIcon(widget.item.name),
                          width: AppLayout.avarage(context) * 0.35,
                          height: AppLayout.avarage(context) * 0.35,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                          child: ItemDetail(
                              item: widget.item,
                              color: widget.color,
                              darkColor: widget.darkColor),
                        ),
                      ],
                    ),
                  ),
                  DialogButton(
                      color: widget.color,
                      buttonText: 'buy',
                      onTap: () => widget.buyItem()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
