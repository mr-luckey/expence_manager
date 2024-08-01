import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/your_goal.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:expence_manager/widgets/custom_card_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SavingPage extends StatefulWidget {
  const SavingPage({super.key});

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  final ExpenseController expenseController = Get.put(ExpenseController());
  late Box<Goal> _goalBox;

  @override
  void initState() {
    super.initState();
    _goalBox = Hive.box<Goal>('goals');
  }

  double calculateTotalGoalsAmount() {
    return _goalBox.values.fold(0, (sum, goal) => sum + goal.amount);
  }

  List<Widget> buildGoalList() {
    return _goalBox.values.map((goal) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(Icons.directions_bike),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  goal.title,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: goal.saveAmount / goal.amount, // progress calculation based on the entered amount
                      minHeight: 6,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${goal.amount}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '\$${goal.amount}', // use the user-entered amount as the target
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    double currentSavings = expenseController.totalExpense;

    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Saving',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: _goalBox.listenable(),
        builder: (context, Box<Goal> box, _) {
          double totalGoalsAmount = calculateTotalGoalsAmount();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomContainer(totalExpenses: currentSavings),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomCard1(
                    totalGoalsAmount: totalGoalsAmount,
                    currentSavings: currentSavings,
                  ),
                ),
                SizedBox(height: 20),
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
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                                      builder: (context) => YourGoal(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Icon(Icons.more_vert_rounded),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: buildGoalList(),
                      ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddGoals()));
                      },
                      title: null,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
