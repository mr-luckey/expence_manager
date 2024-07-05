import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/reminder_model_adapter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:expence_manager/Models/reminder.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/views/edit_reminder.dart';
import 'package:expence_manager/views/set_remainder.dart';
import 'package:path_provider/path_provider.dart';

class ReminderPage extends StatefulWidget {
  const ReminderPage({Key? key, this.reminder}) : super(key: key);
  final ReminderModel? reminder;

  @override
  _ReminderPageState createState() => _ReminderPageState();
}

class _ReminderPageState extends State<ReminderPage>
    with WidgetsBindingObserver {
  late Box<ReminderModel> _reminderBox;
  List<ReminderModel> reminders = [];

  @override
  void initState() {
    super.initState();
    // Initialize Hive when the widget is first inserted into the tree
    openBox();
    print("hello");
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Add observer for lifecycle changes (optional)
    WidgetsBinding.instance.addObserver(this);
  }

   openBox() async {
    // Get the application documents directory where Hive data will be stored
    // final appDocumentDir =
    // await getApplicationDocumentsDirectory();
    // Initialize Hive and open the box for reminders
   await Hive.initFlutter();
   if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ReminderModelAdapter());}
    _reminderBox = await Hive.openBox<ReminderModel>('reminders');
    // Load reminders from the box
    loadReminders();
  }

  @override
  void dispose() {
    // Remove observer for lifecycle changes
    WidgetsBinding.instance.removeObserver(this);
    // Close the reminder box when the widget is disposed
    _reminderBox.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle lifecycle state changes if needed
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // No explicit saving needed as Hive auto-saves on state changes
    }
  }

  Future<void> loadReminders() async {
    // Load reminders from the box into the local list and update the UI
    setState(() {
      reminders.clear();
      reminders.addAll(_reminderBox.values.toList().reversed);
    });
  }

  void saveReminder(ReminderModel reminder) async {
    // Save a reminder to the box and reload the reminders
    // await _reminderBox.put(reminder.key, reminder);
    loadReminders();
  }

  void deleteReminder(int key) async {
    // Delete a reminder from the box and reload the reminders
    await _reminderBox.delete(key);
    loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
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
        // showDeleteConfirmationDialog(reminder.key);
      },
      onTap: () {
        navigateToEditReminder(reminder);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reminder Date: ${reminder.reminderDate}',
                    style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(reminder.description,
                    style:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                Text(reminder.dueDate!, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(int key) {
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
                deleteReminder(key);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToEditReminder(ReminderModel reminder) async {
    final updatedReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditReminder(reminder: reminder),
      ),
    );

    if (updatedReminder != null && updatedReminder is ReminderModel) {
      saveReminder(updatedReminder);
    }
  }

  void navigateToAddReminder() async {
    final newReminder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetReminder(),
      ),
    );

    if (newReminder != null && newReminder is ReminderModel) {
      setState(() {
        reminders.add(newReminder);
      });
      await _reminderBox.add(newReminder);
    }
  }
}
