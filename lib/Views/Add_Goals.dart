import 'package:expence_manager/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/app_bar.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({Key? key}) : super(key: key);

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contributionController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  List<String> _contributions = ['Daily', 'Weekly', 'Monthly', 'Yearly'];
  String _selectedContribution = ''; // Set an initial value

  @override
  void initState() {
    super.initState();
    _contributionController.text = _selectedContribution; // Initialize with the default value
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
        _deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40, // Set the height of the input field
                  child: TextField(
                    controller: _amountController,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40, // Set the height of the input field
                  child: TextField(
                    controller: _descriptionController,
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40, // Set the height of the input field
                  child: TextField(
                    controller: _contributionController,
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
                          _contributionController.text = selectedContribution;
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40, // Set the height of the input field
                  child: TextField(
                    controller: _deadlineController,
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
                  child: genButton(
                    //onTap: _handleAddGoal,
                    text: 'Add Goal',
                    enabled: true,
                    width: double.infinity,
                    bloc: null, onTap: () {  },
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
        width: double.minPositive, // Make the dialog size just enough to fit its content
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
