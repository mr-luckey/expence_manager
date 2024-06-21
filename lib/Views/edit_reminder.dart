import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class EditReminder extends StatefulWidget {
  final ReminderModel reminder;

  EditReminder({
    required this.reminder,
  });

  @override
  _EditReminderState createState() => _EditReminderState();
}

class _EditReminderState extends State<EditReminder> {
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;
  late TextEditingController _dueDateController;

  late Box<ReminderModel> _reminderBox;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.reminder.description);
    _amountController = TextEditingController(text: widget.reminder.amount);
    _dueDateController = TextEditingController(text: widget.reminder.dueDate);
    openBox();
  }

  Future<void> openBox() async {
    _reminderBox = await Hive.openBox<ReminderModel>('reminders');
  }

  void _updateReminder() async {
    widget.reminder.description = _descriptionController.text;
    widget.reminder.amount = _amountController.text;
    widget.reminder.dueDate = _dueDateController.text;

    await _reminderBox.put(widget.reminder.key,
        widget.reminder); // Save updated reminder to Hive box

    Navigator.pop(context,
        widget.reminder); // Pass updated reminder back to the previous screen
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dueDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Reminder'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reminder Date: ${widget.reminder.reminderDate}',
                style: TextStyle(fontSize: 16)),
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
