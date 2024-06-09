import 'package:flutter/material.dart';
import 'custom_expense_card.dart';
import 'record_widget.dart';
import '../constants/records.dart';

class CategoryTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomExpenseCard(),
            ),
          ), // Card for the expense chart
          SizedBox(height: 20), // Space between chart and records
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: recordWidget(records),
            ),
          ), // Card for the records list
        ],
      ),
    );
  }
}
