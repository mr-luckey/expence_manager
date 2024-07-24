import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class YourGoal extends StatefulWidget {
  const YourGoal({super.key});

  @override
  State<YourGoal> createState() => _YourGoalState();
}

class _YourGoalState extends State<YourGoal> {
  late Box<Goal> _goalBox;

  @override
  void initState() {
    super.initState();
    _goalBox = Hive.box<Goal>('goals');
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Your Goals',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "All Goals",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _goalBox.listenable(),
                builder: (context, Box<Goal> box, _) {
                  if (box.values.isEmpty) {
                    return Center(
                      child: Text("No goals added yet."),
                    );
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final goal = box.getAt(index);

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
                                  goal!.title,
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
                                      value: goal.amount / 500, // example progress calculation
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
                                        '\$500', // example target amount
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
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
