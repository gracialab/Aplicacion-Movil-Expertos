import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/core/theme/colors_theme.dart';
import 'package:mr_fix_expert/data/models/bottom_bar_model.dart';
import 'package:mr_fix_expert/core/providers/bottom_navigation.dart';

class BottomNavigation extends StatelessWidget {
  final List<BottomBarModel> pages;
  final int currentPage;

  const BottomNavigation({
    Key? key,
    required this.pages,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: generateOptions(context),
      currentIndex: currentPage,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedFontSize: 12.0,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: ColorsAppTheme.greyAppPalette,
      backgroundColor: Colors.white,
      selectedItemColor: ColorsAppTheme.secondColor,
      onTap: (int index) {
        context.read<BottomBarProvider>().currentPage = index;
      },
    );
  }

  List<BottomNavigationBarItem> generateOptions(BuildContext context) {
    return List.generate(pages.length, (int index) {
      return BottomNavigationBarItem(
        icon: Icon(
          pages[index].icon,
        ),
        label: pages[index].label,
      );
    });
  }
}
