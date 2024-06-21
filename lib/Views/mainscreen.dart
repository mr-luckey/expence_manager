// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:expence_manager/Views/Add_screen.dart';
// import 'package:expence_manager/Views/alert_screen.dart';
// import 'package:expence_manager/Views/home_screen.dart';
// import 'package:expence_manager/Views/setting_screen.dart';
// import 'package:expence_manager/Views/todo_screen.dart';
// import 'package:expence_manager/widgets/card.dart';
// // import 'package:expence_manager/widgets/buttomnavigation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import '../widgets/Topbar.dart';

// class Mainscreen extends StatefulWidget {
//   const Mainscreen({
//     Key? key,
//   }) : super(key: key);
//   // final int selectedIndex;

//   @override
//   State<Mainscreen> createState() => _MainscreenState();
// }

// class _MainscreenState extends State<Mainscreen> {
//   final controller = PersistentTabController(initialIndex: 0);
//   List<PersistentBottomNavBarItem> _navbarItems() {
//     return [
//       PersistentBottomNavBarItem(
//           title: 'Home',
//           icon: Icon(
//             Icons.home_outlined,
//           ),
//           inactiveColorPrimary: Colors.blue,
//           activeColorPrimary: Colors.white),
//       PersistentBottomNavBarItem(
//           title: 'ToDo',
//           icon: Icon(Icons.savings_outlined),
//           inactiveColorPrimary: Colors.blueAccent,
//           activeColorPrimary: Colors.white),
//       PersistentBottomNavBarItem(
//           title: 'Add',
//           icon: Icon(Icons.add_circle_outline_sharp),
//           inactiveColorPrimary: Colors.blueAccent,
//           activeColorPrimary: Colors.white),
//       PersistentBottomNavBarItem(
//           title: 'Alert',
//           icon: Icon(Icons.notifications_none),
//           inactiveColorPrimary: Colors.blueAccent,
//           activeColorPrimary: Colors.white),
//       PersistentBottomNavBarItem(
//           title: 'Setting',
//           icon: Icon(Icons.settings_suggest_outlined),
//           inactiveColorPrimary: Colors.blueAccent,
//           activeColorPrimary: Colors.white)
//     ];
//   }

//   List<Widget> _buildScreen() {
//     return [
//       const HomeScreen(),
//       const SavingPage(),
//       const AddPage(),
//       const AlertScreen(),
//       //mainscree code

//       SettingsScreen(),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       screens: _buildScreen(),
//       items: _navbarItems(),
//       controller: controller,
//       decoration: NavBarDecoration(borderRadius: BorderRadius.circular(10)),
//       backgroundColor: Colors.blue.shade300,
//       navBarStyle: NavBarStyle.style9,
//     );
//   }
// }
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Views/Add_screen.dart';
import 'package:expence_manager/Views/alert_screen.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/setting_screen.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/widgets/card.dart';
// import 'package:expence_manager/widgets/buttomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:random_color_scheme/random_color_scheme.dart';

import '../widgets/Topbar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({
    Key? key,
  }) : super(key: key);
  // final int selectedIndex;

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  final controller = PersistentTabController(initialIndex: 0);

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
      // backgroundColor: Colors.blue.shade300,
      navBarStyle: NavBarStyle.style9,
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
        // inactiveColorPrimary: Colors.blue,
        // activeColorPrimary: Colors.white
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,

        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'ToDo',
        icon: Icon(Icons.savings_outlined),
        //inactiveColorPrimary: Colors.blueAccent,
        // activeColorPrimary: Colors.white
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,

        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Add',
        icon: Icon(Icons.add_circle_outline_sharp),
        //inactiveColorPrimary: Colors.blueAccent,
        //activeColorPrimary: Colors.white
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,

        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Alert',
        icon: Icon(Icons.notifications_none),
        //inactiveColorPrimary: Colors.blueAccent,
        //activeColorPrimary: Colors.white
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: dark ? Colors.blue.shade900 : Colors.white,

        inactiveColorPrimary: dark ? Colors.blue.shade900 : Colors.white,
        title: 'Setting',
        icon: Icon(Icons.settings_suggest_outlined),
        //inactiveColorPrimary: Colors.blueAccent,
        //activeColorPrimary: Colors.white
      )
    ];
  }
}
