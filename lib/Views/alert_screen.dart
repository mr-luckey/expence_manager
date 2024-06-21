import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({super.key});

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  List<String> alertTexts = [
    'You received a new message',
    'Payment received from John',
    'Reminder: Pay electricity bill',
    'Meeting scheduled for tomorrow',
    'Package delivered'
  ];

  List<String> items = [
    'Message',
    'Payment',
    'Electricity Bill',
    'Meeting',
    'Package'
  ];

  List<IconData> icons = [
    Icons.message,
    Icons.payment,
    Icons.lightbulb_outline,
    Icons.event,
    Icons.local_shipping,
  ];

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Notification',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: ListView.builder(
        itemCount: alertTexts.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icons[index %
                            icons.length], // Use different icons dynamically
                        size: 30,
                        //color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(items[index % items.length],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(alertTexts[index],
                              style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Just now', style: TextStyle(fontSize: 14)),
                        Icon(Icons.more_horiz, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
