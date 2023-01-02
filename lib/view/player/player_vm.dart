import 'package:flutter/material.dart';

class PlayerVM {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  int selectedPage = 0;

  String pageTitle = 'inventory';

  void changePage(int pageIndex) {
    selectedPage = pageIndex;
    changePageTitle();
    pageController.animateToPage(selectedPage,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void changePageTitle() {
    switch (selectedPage) {
      case 0:
        pageTitle = 'inventory';
        break;
      case 1:
        pageTitle = 'shop';
        break;
      case 2:
        pageTitle = 'profile';
        break;
    }
  }
}
