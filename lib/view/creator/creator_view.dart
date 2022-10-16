import 'package:dsix/shared/app_colors.dart';
import 'package:dsix/shared/app_images.dart';
import 'package:dsix/shared/app_layout.dart';
import 'package:dsix/shared/app_widgets/layout/app_separator_horizontal.dart';
import 'package:dsix/view/creator/creator_vm.dart';
import 'package:dsix/view/creator_map/creator_map_view.dart';
import 'package:dsix/view/game_settings/game_settings_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../shared/app_widgets/text/app_bar_title.dart';

class CreatorView extends StatefulWidget {
  const CreatorView({Key? key}) : super(key: key);

  @override
  State<CreatorView> createState() => _CreatorViewState();
}

class _CreatorViewState extends State<CreatorView> {
  final CreatorVM _creatorVM = CreatorVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTitle(
          title: _creatorVM.pageTitle,
          color: Colors.black,
        ),
        centerTitle: true,
        toolbarHeight: AppLayout.height(context) * 0.06,
        leading: Row(
          children: [
            const AppSeparatorHorizontal(
              value: 0.005,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.exit_to_app,
                size: AppLayout.height(context) * 0.035,
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.uiColor,
      ),
      body: SafeArea(
        child: PageView(
          controller: _creatorVM.pageController,
          children: const [
            GameSettings(),
            CreatorMap(),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: AppLayout.height(context) * 0.09,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: AppColors.uiColor,
          currentIndex: _creatorVM.selectedPage,
          onTap: (pageIndex) {
            setState(() {
              _creatorVM.changePage(pageIndex);
            });
          },
          items: [
            BottomNavigationBarItem(
                label: 'settings',
                icon: SvgPicture.asset(
                  AppImages.settings,
                  color: (_creatorVM.selectedPage == 0)
                      ? Colors.white
                      : Colors.black,
                  width: AppLayout.height(context) * 0.04,
                  height: AppLayout.height(context) * 0.04,
                )),
            BottomNavigationBarItem(
                label: 'map',
                icon: SvgPicture.asset(
                  AppImages.map,
                  color: (_creatorVM.selectedPage == 1)
                      ? Colors.white
                      : Colors.black,
                  width: AppLayout.height(context) * 0.04,
                  height: AppLayout.height(context) * 0.04,
                )),
          ],
        ),
      ),
    );
  }
}
