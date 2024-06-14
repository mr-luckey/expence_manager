import 'package:expence_manager/Models/reminder.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'Reminder.dart';

class SetReminder extends StatefulWidget {
  const SetReminder({Key? key}) : super(key: key);

  @override
  State<SetReminder> createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dueDateController = TextEditingController();

  void _saveReminder() async {
    String description = _descriptionController.text;
    String amount = _amountController.text;
    String dueDate = _dueDateController.text;

    ReminderModel newReminder = ReminderModel(
      reminderDate: DateFormat('MM/dd/yyyy').format(DateTime.now()), // Assuming reminderDate is today
      description: description,
      amount: amount,
      dueDate: dueDate,
    );

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? remindersJson = prefs.getStringList('reminders');
    List<ReminderModel> reminders = remindersJson != null
        ? remindersJson.map((json) => ReminderModel.fromJson(jsonDecode(json))).toList()
        : [];

    reminders.add(newReminder);

    List<String> updatedRemindersJson = reminders.map((reminder) => jsonEncode(reminder.toJson())).toList();
    await prefs.setStringList('reminders', updatedRemindersJson);
    print("I am running");
    print(newReminder.description);
    Get.to(()=>ReminderPage(reminder: newReminder,));

    Navigator.pop(context, newReminder);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Reminder'),
      ),
      body: Padding(
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
      ),
    );
  }
}
