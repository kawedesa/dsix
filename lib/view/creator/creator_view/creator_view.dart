import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/button/app_bar_circular_button.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/view/creator/creator_view/creator_vm.dart';
import 'package:dsix/view/creator/creator_map/creator_map_view.dart';
import 'package:dsix/view/creator/creator_map_selection/creator_map_selection_view.dart';
import 'package:dsix/view/creator/game_settings/game_settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/game/game.dart';
import '../../../shared/app_widgets/text/app_bar_title.dart';
import '../../../shared/app_widgets/text/app_text.dart';

class CreatorView extends StatefulWidget {
  const CreatorView({Key? key}) : super(key: key);

  @override
  State<CreatorView> createState() => _CreatorViewState();
}

class _CreatorViewState extends State<CreatorView> {
  final CreatorVM _creatorVM = CreatorVM();

  void refresh() {
    setState(() {});
  }

  void displaySnackBar(String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: SizedBox(
          height: AppLayout.avarage(context) * 0.05,
          child: Center(
            child: AppText(
              text: text,
              fontSize: 0.03,
              letterSpacing: 0.005,
              color: Colors.white,
            ),
          )),
      backgroundColor: color,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<Game>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTitle(
          title: _creatorVM.pageTitle,
          color: AppColors.uiColorDark,
        ),
        centerTitle: true,
        toolbarHeight: AppLayout.height(context) * 0.04,
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
                size: AppLayout.height(context) * 0.03,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.uiColor,
      ),
      body: SafeArea(
        child: PageView(
          controller: _creatorVM.pageController,
          children: [
            const GameSettings(),
            (game.map.name == '')
                ? const CreatorMapSelection()
                : CreatorMap(
                    refresh: () => refresh(),
                    displaySnackbar: (text, color) =>
                        displaySnackBar(text, color),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.uiColor,
        height: AppLayout.height(context) * 0.06,
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppSeparatorHorizontal(value: 0.05),
              AppBarCircularButton(
                  onTap: () {
                    setState(() {
                      _creatorVM.changePage(0);
                    });
                  },
                  icon: AppImages.settings,
                  iconColor: AppColors.uiColorDark,
                  color: Colors.transparent,
                  borderColor: AppColors.uiColorDark,
                  size: 0.05),
              AppBarCircularButton(
                  onTap: () {
                    setState(() {
                      _creatorVM.changePage(1);
                    });
                  },
                  icon: AppImages.map,
                  iconColor: AppColors.uiColorDark,
                  color: Colors.transparent,
                  borderColor: AppColors.uiColorDark,
                  size: 0.05),
              const AppSeparatorHorizontal(value: 0.05),
            ],
          ),
        ),
      ),
    );
  }
}