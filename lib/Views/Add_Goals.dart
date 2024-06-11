import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AddGoals extends StatefulWidget {
  const AddGoals({super.key});

  @override
  State<AddGoals> createState() => _AddGoalsState();
}

class _AddGoalsState extends State<AddGoals> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contributionController = TextEditingController();

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
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: '',
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
