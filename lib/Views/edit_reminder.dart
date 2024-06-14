import 'package:expence_manager/Models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditReminder extends StatefulWidget {
  final String reminderDate;
  final String description;
  final String amount;
  final String dueDate;

  EditReminder({
    required this.reminderDate,
    required this.description,
    required this.amount,
    required this.dueDate,
  });

  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late TextEditingController _dueDateController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _amountController = TextEditingController();
    _dueDateController = TextEditingController();
    _loadReminderData();
  }

  void _loadReminderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _descriptionController.text = prefs.getString('reminder_description') ?? widget.description;
      _amountController.text = prefs.getString('reminder_amount') ?? widget.amount;
      _dueDateController.text = prefs.getString('reminder_dueDate') ?? widget.dueDate;
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  void _updateReminder() async {
    ReminderModel reminderModel = ReminderModel(
      reminderDate: widget.reminderDate,
      description: _descriptionController.text,
      amount: _amountController.text,
      dueDate: _dueDateController.text,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('reminder_description', reminderModel.description);
    prefs.setString('reminder_amount', reminderModel.amount);
    prefs.setString('reminder_dueDate', reminderModel.dueDate);
    prefs.setString('reminder_reminderDate', reminderModel.reminderDate);

    Navigator.pop(context, reminderModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reminder Date: ${widget.reminderDate}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _dueDateController,
              decoration: InputDecoration(
                labelText: 'Due Date',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateReminder,
              child: Text('Update Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
