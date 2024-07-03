import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/reminder.dart';
import 'package:expence_manager/Models/reminder_model_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/intl.dart';

class SetReminder extends StatefulWidget {
  const SetReminder({Key? key}) : super(key: key);

  @override
  State<SetReminder> createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  Box<ReminderModel>? _reminderBox; // Made nullable
  bool _isBoxOpened = false;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    final appDocumentDir =
    await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    Hive.registerAdapter(ReminderModelAdapter()); // Register the adapter
    _reminderBox = await Hive.openBox<ReminderModel>('reminders');
    setState(() {
      _isBoxOpened = true; // Set the flag to true when the box is opened
    });
  }

  void _saveReminder() async {
    if (_reminderBox == null) return; // Check if the box is initialized

    String description = _descriptionController.text;
    String amount = _amountController.text;
    String dueDate = _dueDateController.text;

    ReminderModel newReminder = ReminderModel(
      reminderDate: DateFormat('MM/dd/yyyy').format(DateTime.now()),
      description: description,
      amount: amount,
      dueDate: dueDate,
    );

    await _reminderBox!.add(newReminder); // Added null check

    Navigator.pop(context, newReminder); // Pass the new reminder back to the previous screen
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
        title: Text('Set Reminder'),
      ),
      body: _isBoxOpened
          ? Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextFormField(
              controller: _dueDateController,
              decoration: InputDecoration(labelText: 'Due Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveReminder,
              child: Text('Set Reminder'),
            ),
          ],
        ),
      )
          : Center(child: CircularProgressIndicator()), // Show loading indicator while opening the box
    );
  }
}
