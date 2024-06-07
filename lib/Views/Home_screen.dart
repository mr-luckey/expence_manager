import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
