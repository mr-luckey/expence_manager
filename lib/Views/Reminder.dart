import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:expence_manager/Models/reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/views/edit_reminder.dart';
import 'package:expence_manager/views/set_remainder.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key, this.reminder}) : super(key: key);
  final ReminderModel? reminder;

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage> with WidgetsBindingObserver {
  List<ReminderModel> reminders = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadReminders();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      saveReminders();
    }
  }

  Future<void> loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? remindersJson = prefs.getStringList('reminders');

    if (remindersJson != null) {
      setState(() {
        reminders = remindersJson.map((json) => ReminderModel.fromJson(jsonDecode(json))).toList();
      });
    }
  }

  Future<void> saveReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> remindersJson = reminders.map((reminder) => jsonEncode(reminder.toJson())).toList();
    await prefs.setStringList('reminders', remindersJson);
  }

  void deleteReminder(int index) {
    setState(() {
      reminders.removeAt(index);
    });
    saveReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reminders',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return buildReminderRow(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddReminder();
        },
        tooltip: 'Add Reminder',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buildReminderRow(int index) {
    ReminderModel reminder = reminders[index];

    return GestureDetector(
      onLongPress: () {
        showDeleteConfirmationDialog(index);
      },
      onTap: () {
        navigateToEditReminder(index);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reminder Date: ${reminder.reminderDate}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(reminder.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(reminder.amount, style: TextStyle(fontSize: 16)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.more_vert),
                SizedBox(height: 8),
                Text('Due on', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(reminder.dueDate, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Reminder"),
          content: Text("Are you sure you want to delete this reminder?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete"),
              onPressed: () {
                deleteReminder(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToEditReminder(int index) async {
    ReminderModel reminder = reminders[index];
    final ReminderModel? updatedReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminder(reminderDate: '', description: '', amount: '', dueDate: '',
        ),
      ),
    );

    if (updatedReminder != null) {
      setState(() {
        reminders[index] = updatedReminder;
      });
      saveReminders();
    }
  }

  void navigateToAddReminder() async {
    final ReminderModel? newReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetReminder(),
      ),
    );

    if (newReminder != null) {
      setState(() {
        reminders.add(newReminder);
      });
      saveReminders();
    }
  }
}
