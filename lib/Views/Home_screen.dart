import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/Views/total_Expense.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/card.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, BuildContext? initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> records = [
    {
      'iconData': Icons.home,
      'title': 'Home Payment',
      'dateTime': '2024-06-07 14:00',
      'symbols': '\$',
      'amount': 1000,
      'paymentMethod': 'Credit Card',
    },
    {
      'iconData': Icons.star,
      'title': 'Star Payment',
      'dateTime': '2024-06-06 13:00',
      'symbols': '\$',
      'amount': 200,
      'paymentMethod': 'PayPal',
    },
    {
      'iconData': Icons.settings,
      'title': 'Settings Payment',
      'dateTime': '2024-06-05 12:00',
      'symbols': '\$',
      'amount': 300,
      'paymentMethod': 'Debit Card',
    },
    {
      'iconData': Icons.shopping_cart,
      'title': 'Shopping Payment',
      'dateTime': '2024-06-04 11:00',
      'symbols': '\$',
      'amount': 150,
      'paymentMethod': 'Cash',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 10,
            ),
            CardNavigation(),
            SizedBox(
              height: Get.height / 50,
            ),
            Container(
              height: Get.height * 0.06,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Btn(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SavingPage()),
                        );
                      },
                      text: 'Saving',
                      iconData: Icons.add,
                      index: 0,
                    ),
                    Btn(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ReminderPage()),
                        );
                      },
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
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black45),
                    ),
                    child: InkWell
                      (onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TotalExpense()));
                    },
                        child: Center(child: Icon(Icons.more_vert_rounded))),
                  ),
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
                width: double.infinity,
                child: recordWidget(records),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
