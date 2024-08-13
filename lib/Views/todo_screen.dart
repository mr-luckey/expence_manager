import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/Views/goal_detail_screen.dart';
import 'package:expence_manager/Views/your_goal.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:expence_manager/widgets/custom_card_1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SavingPage extends StatefulWidget {
  const SavingPage({super.key});

  @override
  State<SavingPage> createState() => _SavingPageState();
}

class _SavingPageState extends State<SavingPage> {
  final ExpenseController expenseController = Get.put(ExpenseController());
  late Box<Goal> _goalBox;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _goalBox = Hive.box<Goal>('goals');

    tz.initializeTimeZones();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Optional: Schedule notifications for all existing goals
    _scheduleNotificationsForGoals();
  }

  // Function to show notification
  Future<void> _showNotification(DateTime deadline, String contribution, String title) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your_channel_id', 'your_channel_name',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics);
    var scheduledTime = tz.TZDateTime.from(deadline, tz.local);
    print('Notification scheduled for: $scheduledTime');

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        'This is a scheduled notification',
        scheduledTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime);
  }

  // Schedule notifications for all goals
  void _scheduleNotificationsForGoals() {
    for (var goal in _goalBox.values) {
      _showNotification(goal.deadline, goal.contributionType, goal.title);
    }
  }

  double calculateTotalGoalsAmount() {
    return _goalBox.values.fold(0, (sum, goal) => sum + goal.amount);
  }

  double calculateTotalSavedAmount() {
    return _goalBox.values.fold(0, (sum, goal) => sum + goal.saveAmount);
  }

  List<Widget> buildGoalList() {
    return _goalBox.values.map((goal) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditGoal(goal: goal),
            ),
          );
        },
        child: Padding(
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
                            '\$${goal.saveAmount.toStringAsFixed(2)}', // Display two decimal points
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '\$${goal.amount.toStringAsFixed(2)}', // Display two decimal points
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ]
          ),
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
          double totalSavedAmount = calculateTotalSavedAmount();

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
                    amount: totalGoalsAmount,
                    saveAmount: totalSavedAmount,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
