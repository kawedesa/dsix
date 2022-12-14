import 'package:flutter/material.dart';

class CreatorVM {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int selectedPage = 0;

  String pageTitle = 'game settings';

  void changePage(int pageIndex) {
    selectedPage = pageIndex;
    changePageTitle();
    pageController.animateToPage(selectedPage,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void changePageTitle() {
    switch (selectedPage) {
      case 0:
        pageTitle = 'game settings';
        break;
      case 1:
        pageTitle = 'map';
        break;
    }
  }
}
