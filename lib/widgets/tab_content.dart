import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'custom_catagory_card.dart';
import 'record_widget.dart';
import '../constants/records.dart';

class CategoryTabContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

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
              child: CustomCategoryCard(
                expenses: [],
                labels: [],
                colors: [],
                records: [],
              ),
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
              child: recordWidget(records, dark),
            ),
          ), // Card for the records list
        ],
      ),
    );
  }
}
