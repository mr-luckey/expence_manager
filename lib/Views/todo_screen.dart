import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/your_goal.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:expence_manager/widgets/custom_card_1.dart';
import 'package:expence_manager/widgets/item_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SavingPage extends StatefulWidget {
  const SavingPage({super.key});

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  double progress = 0.6; // Example progress value

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Saving',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20), // Space between app bar and text
            Center(
              child: Text(
                "Current Savings",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 50), // Space between text and circular container
            Center(
              child: CustomContainer(),
            ),
            SizedBox(height: 20), // Space between circular container and card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomCard1(),
            ),
            SizedBox(height: 20), // Space between card and new text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Your Goal",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black45),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => YourGoal()));
                            },
                            child: Center(
                              child: Icon(Icons.more_vert_rounded),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ItemList(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: CustomElevatedButton(
                  isdark: dark,
                  label: '',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddGoals()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
