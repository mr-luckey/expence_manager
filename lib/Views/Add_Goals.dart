import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({Key? key}) : super(key: key);

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController contributionController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  List<String> _contributions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  String _selectedContribution = '';

  @override
  void initState() {
    super.initState();
    contributionController.text = _selectedContribution;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        deadlineController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _handleAddGoal() async {
    final String title = _titleController.text;
    final double amount = double.tryParse(_amountController.text) ?? 0;
    final String contributionType = contributionController.text;
    final String deadline = deadlineController.text;
    final String currentTime = "${DateTime.now().hour}:${DateTime.now().minute}";

    // Calculate save amount based on contribution type and deadline
    final DateTime deadlineDate = DateTime.parse(deadline);
    final int minutesUntilDeadline = deadlineDate.difference(DateTime.now()).inMinutes;
    double saveAmount = 0;
    double dividedAmount = 0;

    if (contributionType == 'Daily') {
      saveAmount = amount / (minutesUntilDeadline / 2);
      dividedAmount = saveAmount;
    } else if (contributionType == 'Weekly') {
      saveAmount = amount / (minutesUntilDeadline / (7 * 24 * 60));
      dividedAmount = saveAmount;
    } else if (contributionType == 'Monthly') {
      saveAmount = amount / (minutesUntilDeadline / (30 * 24 * 60));
      dividedAmount = saveAmount;
    } else if (contributionType == 'Yearly') {
      saveAmount = amount / (minutesUntilDeadline / (365 * 24 * 60));
      dividedAmount = saveAmount;
    }

    final goal = Goal(
      title: title,
      amount: amount,
      contributionType: contributionType,
      deadline:DateTime(deadlineDate.year,deadlineDate.month,deadlineDate.day),
      saveAmount: 0, // Initial save amount
      lastContributionDate: DateTime.now(), // Initialize with the current date
      dividedAmount: dividedAmount,
      time: currentTime, // Set current time
    );

    // Print all the parameters
    print('Title: ${goal.title}');
    print('Amount: ${goal.amount}');
    print('Contribution Type: ${goal.contributionType}');
    print('Deadline: ${goal.deadline}');
    print('Save Amount: ${goal.saveAmount}');
    print('Last Contribution Date: ${goal.lastContributionDate}');
    print('Divided Amount: ${goal.dividedAmount}');
    print('Time: ${goal.time}');

    final box = Hive.box<Goal>('goals');
    await box.add(goal);

    print('Goal added successfully.');

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SavingPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Add Goal',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Income Title',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _titleController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '',
                      suffixIcon: Icon(Icons.attach_money),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Contribution Type',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: contributionController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onTap: () async {
                      String? selectedContribution = await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return ContributionDialog(
                            contributions: _contributions,
                            initialValue: _selectedContribution,
                          );
                        },
                      );

                      if (selectedContribution != null) {
                        setState(() {
                          _selectedContribution = selectedContribution;
                          contributionController.text = selectedContribution;
                        });
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Deadline',
                  style: TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40,
                  child: TextField(
                    controller: deadlineController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: '',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomElevatedButton(
                    isdark: dark,
                    label: 'Add Goal',
                    onPressed: _handleAddGoal,
                    title: null,
                  ),
                ),
              ),
            ],
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
