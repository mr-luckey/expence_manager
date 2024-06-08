import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/buttons.dart';
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
          SizedBox(
            height: Get.height / 10,
          ),
          CardNavigation(),
          SizedBox(
            height: Get.height / 50,
          ),
          Container(
            // color: Colors.white,
            // color: Colors.black,
            height: Get.height * 0.06,
            width: Get.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Btn(
                    onTap: () {},
                    text: 'saving',
                    iconData: Icons.add,
                    index: 0,
                  ),
                  Btn(
                    onTap: () {},
                    text: 'Remind',
                    iconData: Icons.notifications_active_outlined,
                    index: 1,
                  ),
                  Btn(
                    onTap: () {},
                    text: 'Budget',
                    iconData: Icons.savings_outlined,
                    index: 2,
                  ),
                ],
                // children: [Btn(onTap: () {}, text: 'jdnvjds', iconData: Icons.add);],
              ),
            ),
          ),

          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Padding(
          //       padding: const EdgeInsets.all(20.0),
          //       child: Card(
          //         elevation: 10,
          //         borderOnForeground: true,
          //         child: Container(
          //           color: Colors.blue,
          //           height: Get.height,
          //           width: Get.width,
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
