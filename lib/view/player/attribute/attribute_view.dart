import 'package:dsix/model/user.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/app_slider.dart';
import 'package:dsix/shared/app_widgets/button/app_text_button.dart';
import 'package:dsix/shared/app_widgets/dialog/text_dialog.dart';
import 'package:dsix/shared/app_widgets/dialog/text_input_dialog.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_vertical.dart';
import 'package:dsix/shared/app_widgets/text/app_title.dart';
import 'package:dsix/view/player/attribute/attribute_vm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../shared/app_widgets/text/app_bar_title.dart';

class AttributeView extends StatefulWidget {
  const AttributeView({Key? key}) : super(key: key);

  @override
  State<AttributeView> createState() => _AttributeViewState();
}

class _AttributeViewState extends State<AttributeView> {
  final AttributeVM _attributeVM = AttributeVM();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTitle(
          title: 'assign attributes',
          color: user.darkColor,
        ),
        centerTitle: true,
        toolbarHeight: AppLayout.height(context) * 0.06,
        leading: Row(
          children: [
            const AppSeparatorHorizontal(
              value: 0.003,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.exit_to_app,
                color: user.darkColor,
                size: AppLayout.height(context) * 0.035,
              ),
            ),
          ],
        ),
        backgroundColor: user.color,
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: AppLayout.shortest(context) * 0.9,
            height: AppLayout.height(context) * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppTitle(
                  title: 'points:${user.player.attributes.availablePoints}',
                  color: user.color,
                ),
                const AppSeparatorVertical(value: 0.02),
                AppSlider(
                  width: AppLayout.shortest(context) * 0.5,
                  height: AppLayout.shortest(context) * 0.09,
                  range: 5,
                  sliderTitle: 'attack',
                  sliderDescription:
                      'this represents how well you can attack your enemies.',
                  color: user.color,
                  icon: AppImages.attack,
                  iconColor: user.darkColor,
                  value: user.player.attributes.attack,
                  add: () {
                    setState(() {
                      _attributeVM.addAttribute(user.player, 'attack');
                    });
                  },
                  remove: () {
                    setState(() {
                      _attributeVM.removeAttribute(user.player, 'attack');
                    });
                  },
                ),
                const AppSeparatorVertical(value: 0.02),
                AppSlider(
                  width: AppLayout.shortest(context) * 0.5,
                  height: AppLayout.shortest(context) * 0.09,
                  range: 5,
                  sliderTitle: 'defend',
                  sliderDescription:
                      'this represents how well you can protect yourself and others',
                  color: user.color,
                  icon: AppImages.defend,
                  iconColor: user.darkColor,
                  value: user.player.attributes.defend,
                  add: () {
                    setState(() {
                      _attributeVM.addAttribute(user.player, 'defend');
                    });
                  },
                  remove: () {
                    setState(() {
                      _attributeVM.removeAttribute(user.player, 'defend');
                    });
                  },
                ),
                const AppSeparatorVertical(value: 0.02),
                AppSlider(
                  width: AppLayout.shortest(context) * 0.5,
                  height: AppLayout.shortest(context) * 0.09,
                  range: 5,
                  sliderTitle: 'move',
                  sliderDescription: 'this represents how far you can move.',
                  color: user.color,
                  icon: AppImages.move,
                  iconColor: user.darkColor,
                  value: user.player.attributes.move.attribute,
                  add: () {
                    setState(() {
                      _attributeVM.addAttribute(user.player, 'move');
                    });
                  },
                  remove: () {
                    setState(() {
                      _attributeVM.removeAttribute(user.player, 'move');
                    });
                  },
                ),
                const AppSeparatorVertical(value: 0.02),
                AppSlider(
                  width: AppLayout.shortest(context) * 0.5,
                  height: AppLayout.shortest(context) * 0.09,
                  range: 5,
                  sliderTitle: 'look',
                  sliderDescription:
                      'this represents how far you can see and your ability to find things.',
                  color: user.color,
                  icon: AppImages.look,
                  iconColor: user.darkColor,
                  value: user.player.attributes.vision.attribute,
                  add: () {
                    setState(() {
                      _attributeVM.addAttribute(user.player, 'vision');
                    });
                  },
                  remove: () {
                    setState(() {
                      _attributeVM.removeAttribute(user.player, 'vision');
                    });
                  },
                ),
                const AppSeparatorVertical(value: 0.025),
                AppTextButton(
                    buttonText: 'confirm',
                    color: user.color,
                    onTap: (user.player.attributes.availablePoints == 0)
                        ? () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TextInputDialog(
                                    title: 'choose a name',
                                    color: user.color,
                                    onConfirm: (String name) {
                                      if (name == '') {
                                        return;
                                      }
                                      Navigator.pop(context);
                                      _attributeVM.chooseName(
                                          user.player, name);
                                      _attributeVM.goToPlayerView(context);
                                    },
                                  );
                                });
                          }
                        : () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TextDialog(
                                    title: 'spend your points',
                                    color: user.color,
                                    dialogText:
                                        'assign points by clicking on the + button next to each attribute.',
                                  );
                                });
                          }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
