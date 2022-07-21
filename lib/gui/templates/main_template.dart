import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mr_fix_expert/gui/widgets/bottom_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mr_fix_expert/data/models/bottom_bar_model.dart';
import 'package:mr_fix_expert/gui/templates/main_controller.dart';
import 'package:mr_fix_expert/gui/views/home_view/home_view.dart';
import 'package:mr_fix_expert/gui/views/sales_view/sales_view.dart';
import 'package:mr_fix_expert/core/providers/bottom_navigation.dart';
import 'package:mr_fix_expert/gui/views/profile_view/profile_view.dart';
import 'package:mr_fix_expert/gui/views/services_view/services_view.dart';
import 'package:mr_fix_expert/gui/views/tutorial_view/tutorial_home_view.dart';

// Pages
final List<BottomBarModel> pages = [
  BottomBarModel(
    icon: Feather.home,
    label: 'Inicio',
    title: 'Inicio',
    widget: const HomeView(),
  ),
  BottomBarModel(
    icon: Feather.calendar,
    label: 'Servicios',
    title: 'Servicios',
    widget: const ServicesHome(),
  ),
  BottomBarModel(
    icon: Feather.dollar_sign,
    label: 'Ventas',
    title: 'Ventas',
    widget: const SalesView(),
  ),
  BottomBarModel(
    icon: Feather.youtube,
    label: 'Tutoriales',
    title: 'Tutoriales',
    widget: const TutorialView(),
  ),
  BottomBarModel(
    icon: Feather.smile,
    label: 'Perfil',
    title: 'Perfil',
    widget: const ProfileView(),
  ),
];

class MainTemplate extends StatefulWidget {
  const MainTemplate({Key? key}) : super(key: key);

  @override
  State<MainTemplate> createState() => _MainTemplateState();
}

class _MainTemplateState extends State<MainTemplate> {
  @override
  void initState() {
    MainController(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int currentPage = context.watch<BottomBarProvider>().currentPage;
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: List.generate(
          pages.length,
          (index) => pages[index].widget,
        ),
      ),
      bottomNavigationBar: BottomNavigation(
        pages: pages,
        currentPage: currentPage,
      ),
    );
  }
}
