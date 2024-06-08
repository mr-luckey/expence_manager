import 'package:expence_manager/Controllers/controller.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
// import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/buttons.dart';
// import 'package:expence_manager/widgets/card.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../Controllers/controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Button1Controller buttonController = Get.put(Button1Controller());

  final List<Map<String, dynamic>> records1 = [
    {
      'iconData': Icons.home,
      'title': 'Home Payment 1',
      'dateTime': '2024-06-07 14:00',
      'symbols': '\$',
      'amount': 1000,
      'paymentMethod': 'Credit Card',
    },
    {
      'iconData': Icons.star,
      'title': 'Star Payment 2',
      'dateTime': '2024-06-06 13:00',
      'symbols': '\$',
      'amount': 200,
      'paymentMethod': 'PayPal',
    },
    {
      'iconData': Icons.settings,
      'title': 'Settings Payment 3',
      'dateTime': '2024-06-05 12:00',
      'symbols': '\$',
      'amount': 300,
      'paymentMethod': 'Debit Card',
    },
    // Add more items if needed
  ];

  final List<Map<String, dynamic>> records2 = [
    {
      'iconData': Icons.home,
      'title': 'Home Payment 1',
      'dateTime': '2024-06-07 14:00',
      'symbols': '\$',
      'amount': 1000,
      'paymentMethod': 'Credit Card',
    },
    {
      'iconData': Icons.star,
      'title': 'Star Payment 2',
      'dateTime': '2024-06-06 13:00',
      'symbols': '\$',
      'amount': 200,
      'paymentMethod': 'PayPal',
    },
    {
      'iconData': Icons.settings,
      'title': '5 Star dinner',
      'dateTime': '2024-06-05 12:00',
      'symbols': '\$',
      'amount': 800,
      'paymentMethod': 'Jazzcash',
    },
    // Add more items if needed
  ];

  final List<Map<String, dynamic>> records3 = [
    {
      'iconData': Icons.home,
      'title': 'Home Payment 1',
      'dateTime': '2024-06-07 14:00',
      'symbols': '\$',
      'amount': 1000,
      'paymentMethod': 'Credit Card',
    },
    {
      'iconData': Icons.star,
      'title': 'Star Payment 2',
      'dateTime': '2024-06-06 13:00',
      'symbols': '\$',
      'amount': 200,
      'paymentMethod': 'PayPal',
    },
    {
      'iconData': Icons.settings,
      'title': 'vehicle repair',
      'dateTime': '2024-06-05 12:00',
      'symbols': '\$',
      'amount': 700,
      'paymentMethod': 'easypaisa',
    },
    // Add more items if needed
  ];
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
                    onTap: () => buttonController.selectButton(0),
                    text: 'saving',
                    iconData: Icons.add,
                    index: 0,
                  ),
                  Btn(
                    onTap: () => buttonController.selectButton(1),
                    text: 'Remind',
                    iconData: Icons.notifications_active_outlined,
                    index: 1,
                  ),
                  Btn(
                    onTap: () => buttonController.selectButton(2),
                    text: 'Budget',
                    iconData: Icons.savings_outlined,
                    index: 2,
                  ),
                ],
                // children: [Btn(onTap: () {}, text: 'jdnvjds', iconData: Icons.add);],
              ),
            ),
          ),
          SizedBox(
            height: Get.height / 60,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Latest Entries",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black45)),
                    child: Center(child: Icon(Icons.more_vert_rounded))),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Container(
              height: 400,
              // color: Colors.blue,
              width: double.infinity,
              child: Obx(() {
                if (buttonController.selectedIndex.value == 0) {
                  return recordWidget(records1);
                } else if (buttonController.selectedIndex.value == 1) {
                  return recordWidget(records2);
                } else {
                  return recordWidget(records3);
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
