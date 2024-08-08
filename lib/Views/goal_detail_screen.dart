import 'package:expence_manager/Models/goal_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'dart:async';
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
  bool _isCardVisible = true;
  List<String> contributions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedContribution = widget.goal.contributionType;
    _isButtonDisabled = _isContributionMadeForCurrentPeriod();
    _startTimerIfNeeded();
    _logGoalsData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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

  bool _isContributionMadeForCurrentPeriod() {
    if (widget.goal.lastContributionDate == null) return false;
    final lastContributionDate = widget.goal.lastContributionDate!;
    final now = DateTime.now();

    switch (_selectedContribution) {
      case 'Daily':
      case 'Weekly':
      case 'Monthly':
        final differenceInMinutes = now.difference(lastContributionDate).inMinutes;
        return differenceInMinutes < 2;
      case 'Yearly':
        return lastContributionDate.year == now.year;
      default:
        return false;
    }
  }

  void _startTimerIfNeeded() {
    if ((_selectedContribution == 'Daily' || _selectedContribution == 'Weekly' || _selectedContribution == 'Monthly') && widget.goal.lastContributionDate != null) {
      final lastContributionDate = widget.goal.lastContributionDate!;
      final now = DateTime.now();
      final differenceInMinutes = now.difference(lastContributionDate).inMinutes;

      if (differenceInMinutes < 2) {
        _timer = Timer(Duration(minutes: 2 - differenceInMinutes), () {
          setState(() {
            _isButtonDisabled = false;
          });
        });
      }
    }
  }

  void _updateSavedAmount() async {
    final box = Hive.box<Goal>('goals');
    final goal = box.get(widget.goal.key); // Assuming you have a key to fetch the goal
    if (goal != null) {
      double newSavedAmount = goal.saveAmount + goal.dividedAmount;
      if (newSavedAmount > goal.amount) {
        newSavedAmount = goal.amount; // Ensure the saved amount doesn't exceed the target amount
      }
      goal.saveAmount = newSavedAmount;
      goal.lastContributionDate = DateTime.now(); // Update the last contribution date

      await goal.save(); // Save the updated goal
      setState(() {
        _isButtonDisabled = true; // Disable the button after updating the amount
        _isCardVisible = false; // Hide the Contribution card
      });
      _startTimerIfNeeded();
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

            if (isDeadlinePassed) {
              setState(() {
                _isButtonDisabled = false; // Enable the button if the deadline has passed
              });
            }

            return _isCardVisible
                ? Card(
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
                    Text('Amount: \$${goal.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Saved Amount: \$${goal.saveAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Current Date: $currentDate', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Deadline Date: $deadlineDate', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Contribution Type: $_selectedContribution', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text('Divided Amount: \$${goal.dividedAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)), // Show divided amount
                    Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () {
                          if (!isDeadlinePassed) {
                            _updateSavedAmount();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Deadline has passed.')),
                            );
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
            )
                : Container(); // Hide the Contribution card when _isCardVisible is false
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
