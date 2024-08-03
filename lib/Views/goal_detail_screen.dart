import 'package:expence_manager/Models/goal_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'dart:developer' as developer;

class EditGoal extends StatefulWidget {
  final Goal goal;

  const EditGoal({required this.goal, Key? key}) : super(key: key);

  @override
  _EditGoalState createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  late String _selectedContribution;
  bool _isButtonDisabled = false;
  List<String> contributions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

  @override
  void initState() {
    super.initState();
    _selectedContribution = widget.goal.contributionType;
    _logGoalsData();
  }

  Future<void> _logGoalsData() async {
    final box = Hive.box<Goal>('goals');
    final goals = box.values.toList();
    for (var goal in goals) {
      developer.log('Goal: ${goal.title}, Amount: ${goal.amount}, Saved Amount: ${goal.saveAmount}, Contribution Type: ${goal.contributionType}, Deadline: ${goal.deadline}');
    }
  }

  Future<void> _selectContributionType(BuildContext context) async {
    String? selectedContribution = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return ContributionDialog(
          contributions: contributions,
          initialValue: _selectedContribution,
        );
      },
    );

    if (selectedContribution != null) {
      setState(() {
        _selectedContribution = selectedContribution;
      });
    }
  }

  Future<bool> _goalExists(String contributionType) async {
    final box = Hive.box<Goal>('goals');
    final goals = box.values.where((goal) => goal.contributionType == contributionType);
    return goals.isNotEmpty;
  }

  void _updateSavedAmount(double newAmount) async {
    final box = Hive.box<Goal>('goals');
    final goal = box.get(widget.goal.key); // Assuming you have a key to fetch the goal
    if (goal != null) {
      goal.saveAmount += newAmount;
      await goal.save(); // Save the updated goal
      setState(() {
        _isButtonDisabled = true; // Disable the button after updating the amount
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Amount added and saved.')),
      );
    }
  }

  bool _isDeadlinePassed() {
    return DateTime.now().isAfter(widget.goal.deadline);
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: Hive.box<Goal>('goals').watch(),
          builder: (context, snapshot) {
            final goalBox = Hive.box<Goal>('goals');
            final goal = goalBox.get(widget.goal.key);

            if (goal == null) {
              return Center(child: Text('Goal not found.'));
            }

            final deadlineDate = DateFormat('yyyy-MM-dd').format(goal.deadline);
            final isDeadlinePassed = _isDeadlinePassed();

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Title: ${goal.title}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Amount: \$${goal.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Saved Amount: \$${goal.saveAmount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Current Date: $currentDate', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Deadline Date: $deadlineDate', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Contribution Type: $_selectedContribution', style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () async {
                          double newAmount = 10.0; // Replace with the desired amount to add
                          if (isDeadlinePassed) {
                            _updateSavedAmount(newAmount);
                          } else {
                            bool exists = await _goalExists(_selectedContribution);
                            if (exists) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Goal with $_selectedContribution contribution type already exists.')),
                              );
                            } else {
                              await _selectContributionType(context);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20),
                        ),
                        child: Icon(Icons.add, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ContributionDialog extends StatelessWidget {
  final List<String> contributions;
  final String initialValue;

  ContributionDialog({required this.contributions, required this.initialValue});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select Contribution Type'),
      content: Container(
        width: double.minPositive,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: contributions.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(contributions[index]),
              onTap: () {
                Navigator.of(context).pop(contributions[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
