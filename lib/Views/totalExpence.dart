// import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
// import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
// import 'package:expence_manager/Views/Add_screen.dart';
// import 'package:expence_manager/Views/Home_screen.dart';
// import 'package:expence_manager/Views/alert_screen.dart';
// import 'package:expence_manager/Views/setting_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'todo_screen.dart';

// class Totalexpence extends StatefulWidget {
//   const Totalexpence({
//     super.key,
//   });
//   // final int selectedIndex;

//   @override
//   State<Totalexpence> createState() => _TotalexpenceState();
// }

// class _TotalexpenceState extends State<Totalexpence> {
//   @override
//   void initState() {
//     // selectedIndex = widget.selectedIndex;

//     super.initState();
//   }

//   late int selectedIndex;
//   final widgetOptions = [
//     const HomeScreen(),
//     const TodoScreen(),
//     const AddScreen(),
//     const AlertScreen(),
//     const SettingScreen(),


//   ];
//   void onItemTapped(index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   Future<bool> _willPopCallback() async {
//     if (selectedIndex == 0) {
//       // exit(0);
//       SystemNavigator.pop();
//       return true;
//     } else if (selectedIndex == 1) {
//       setState(() {
//         selectedIndex = 0;
//       });
//     } else if (selectedIndex == 2) {
//       setState(() {
//         selectedIndex = 0;
//       });
//     } else if (selectedIndex == 3) {
//       setState(() {
//         selectedIndex = 0;
//       });
//     } else if (selectedIndex == 4) {
//       setState(() {
//         selectedIndex = 0;
//       });
//     }
//     // await showDialog or Show add banners or whatever
//     // then
//     return false;
//     // return true if the route to be popped
//   }

//   // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _willPopCallback,
//       child: Scaffold(
//         body: const Column(
//           children: [
//             // Expanded(child: widgetOptions.elementAt(selectedIndex)),
//           ],
//         ),
//         bottomNavigationBar: CurvedNavigationBar(
//           // key: _bottomNavigationKey,
//           index: 0,
//           items: const [
//             CurvedNavigationBarItem(
//               child: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.bookmark_remove_outlined),
//               label: 'ToDo',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(
//                 Icons.add,
//                 size: 50,
//                 color: Colors.blue,
//               ),
//               // label: 'Chat',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.notifications_none_rounded),
//               label: 'Alert',
//             ),
//             CurvedNavigationBarItem(
//               child: Icon(Icons.settings_suggest_outlined),
//               label: 'Settings',
//             ),
//           ],
//           color: Colors.white,
//           buttonBackgroundColor: Colors.white,
//           backgroundColor: Colors.blueAccent,

//           animationCurve: Curves.easeInOut,
//           animationDuration: const Duration(milliseconds: 600),
//           onTap: onItemTapped,
//           // letIndexChange: (index) => true,
//         ),
//       ),
//     );
//   }
// }
// Future changeScreen(BuildContext context, Widget screen,
//       {bool withNavBar = true}) async {
//     debugPrint('pushing screen $screen');
//     await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
//       context,
//       settings: RouteSettings(name: '/$screen'),
//       screen: screen,
//       withNavBar: true,
//       pageTransitionAnimation: PageTransitionAnimation.cupertino,
//     );
    // Get.to(screen);
  // }