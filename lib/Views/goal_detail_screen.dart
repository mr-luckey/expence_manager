import 'package:expence_manager/Models/goal_model.dart';
import 'package:flutter/material.dart'; // Corrected import
import 'package:intl/intl.dart'; // Import for date formatting
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
  List<String> contributions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  bool _canCompleteDaily = false;
  bool _amountAdded = false;
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedContribution = widget.goal.contributionType;
    _logGoalsData();
    _checkDailyCompletion();
  }

  Future<void> _logGoalsData() async {
    final box = Hive.box<Goal>('goals');
    final goals = box.values.toList();
    for (var goal in goals) {
      developer.log('Goal: ${goal.title}, Amount: ${goal.amount}, Saved Amount: ${goal.saveAmount}, Contribution Type: ${goal.contributionType}, Deadline: ${goal.deadline}');
    }
  }

  void _checkDailyCompletion() {
    // Add your condition here to check if the daily goal can be completed
    // For example, let's assume the daily goal can be completed if savedAmount is less than amount
    setState(() {
      _canCompleteDaily = widget.goal.saveAmount < widget.goal.amount;
    });
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
        _amountAdded = true; // Disable the button after adding the amount
      });
    }
  }

  bool _isDeadlinePassed() {
    return DateTime.now().isAfter(widget.goal.deadline);
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final deadlineDate = DateFormat('yyyy-MM-dd').format(widget.goal.deadline); // Assuming 'deadline' is a DateTime field in Goal

    return Scaffold(
      appBar: AppBar(
        title: Text('View Goal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: ${widget.goal.title}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Amount: \$${widget.goal.amount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Saved Amount: \$${widget.goal.saveAmount.toStringAsFixed(0)}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Current Date: $currentDate', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Deadline Date: $deadlineDate', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Contribution Type: $_selectedContribution', style: TextStyle(fontSize: 18)),
                Spacer(),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _canCompleteDaily && !_amountAdded ? () async {
                      double newAmount = double.tryParse(_amountController.text) ?? 0; // Get the user-entered amount
                      _updateSavedAmount(newAmount);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Amount added and saved.')),
                      );
                    } : null, // Disable button if the daily goal cannot be completed or the amount has been added
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
