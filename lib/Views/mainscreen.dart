import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Views/Add_screen.dart';
import 'package:expence_manager/Views/alert_screen.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/setting_screen.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:random_color_scheme/random_color_scheme.dart';

import '../widgets/Topbar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    Key? key,
  }) : super(key: key);

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final controller = PersistentTabController(initialIndex: 0);
  late Future<Box<IncomeModel>> _incomeBoxFuture;

  @override
  void initState() {
    super.initState();
    _incomeBoxFuture = Hive.openBox<IncomeModel>('incomes');
  }

  List<Widget> _buildScreen() {
    return [
      const HomeScreen(),
      const SavingPage(),
      const AddPage(),
      const AlertScreen(),
      SettingsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    return FutureBuilder<Box<IncomeModel>>(
      future: _incomeBoxFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error loading data')),
          );
        } else {
          return PersistentTabView(
            backgroundColor: dark ? Colors.white : Colors.blue.shade900,
            context,
            screens: _buildScreen(),
            items: _navbarItems(dark),
            controller: controller,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10),
              colorBehindNavBar: dark ? Colors.white : Colors.blue.shade900,
            ),
            navBarStyle: NavBarStyle.style9,
          );
        }
      },
    );
  }

  List<PersistentBottomNavBarItem> _navbarItems(dark) {
    return [
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Home',
        icon: Icon(
          Icons.home_outlined,
        ),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'ToDo',
        icon: Icon(Icons.savings_outlined),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Add',
        icon: Icon(Icons.add_circle_outline_sharp),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Alert',
        icon: Icon(Icons.notifications_none),
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Setting',
        icon: Icon(Icons.settings_suggest_outlined),
      )
    ];
  }
}
