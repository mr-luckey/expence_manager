import 'package:expence_manager/Views/set_remainder.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// Import the SetReminder screen

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    // Get the current date
    DateTime currentDate = DateTime.now();
    // Get the due date (10 days from now)
    DateTime dueDate = currentDate.add(Duration(days: 10));
    // Format the dates
    String formattedCurrentDate = DateFormat('MM/dd/yyyy').format(currentDate);
    String formattedDueDate = DateFormat('MM/dd/yyyy').format(dueDate);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reminder',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            buildReminderRow(
              reminderDate: formattedCurrentDate,
              description: 'Rent Payment',
              amount: '\$1200',
              dueDate: formattedDueDate,
            ),
            Divider(),
            buildReminderRow(
              reminderDate: formattedCurrentDate,
              description: 'Electricity Bill',
              amount: '\$100',
              dueDate: formattedDueDate,
            ),
            Divider(),
            buildReminderRow(
              reminderDate: formattedCurrentDate,
              description: 'Water Bill',
              amount: '\$50',
              dueDate: formattedDueDate,
            ),
            Divider(),
            buildReminderRow(
              reminderDate: formattedCurrentDate,
              description: 'Internet Bill',
              amount: '\$60',
              dueDate: formattedDueDate,
            ),
            Divider(),
            buildReminderRow(
              reminderDate: formattedCurrentDate,
              description: 'Credit Card Payment',
              amount: '\$500',
              dueDate: formattedDueDate,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildReminderRow({
    required String reminderDate,
    required String description,
    required String amount,
    required String dueDate,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SetReminder()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // First Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Reminder Date: $reminderDate', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(amount, style: TextStyle(fontSize: 16)),
              ],
            ),
            // Second Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(Icons.more_vert),
                SizedBox(height: 8),
                Text('Due on', style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(dueDate, style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
