import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:expence_manager/Views/card.dart';
import 'package:expence_manager/widgets/buttomnavigation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../widgets/Topbar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            topbar(
              title: 'Overview',
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
            SizedBox(
              height: Get.height / 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardbtn(
                    clicked: false,
                    onTap: () {},
                    text: 'Income',
                    amount: 5000,
                    iconData: Icons.wallet),
                cardbtn(
                    onTap: () {},
                    clicked: true,
                    text: 'Total Expenses',
                    amount: 700,
                    iconData: Icons.wallet),
                cardbtn(
                    onTap: () {},
                    text: 'Total salary',
                    amount: 60000,
                    clicked: false,
                    iconData: Icons.wallet),
              ],
            ),

            // ButtonBar()
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.bookmark_remove_outlined),
              label: 'ToDo',
            ),
            CurvedNavigationBarItem(
              child: Icon(
                Icons.add,
                size: 50,
                color: Colors.blue,
              ),
              // label: 'Chat',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.notifications_none_rounded),
              label: 'Alert',
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.settings_suggest_outlined),
              label: 'Settings',
            ),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              // _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
    );
  }
}
