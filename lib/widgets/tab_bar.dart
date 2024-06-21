import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> tabViews;

  CustomTabBar({required this.tabs, required this.tabViews});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10.0), // Add padding to the bottom side
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: DefaultTabController(
          length: tabs.length,
          child: Column(
            children: [
              Container(
                constraints: BoxConstraints(maxHeight: 150.0),
                child: Material(
                  // color: Colors.transparent, // Set the tab bar background color to transparent
                  child: TabBar(
                    tabs: tabs,
                    // indicator: BoxDecoration(), // Remove the indicator property to remove the indicator color
                    // labelColor: Colors.black, // Set the selection text color to white
                    // unselectedLabelColor: Colors.grey, // Set the unselected text color to gray
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: tabViews,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
