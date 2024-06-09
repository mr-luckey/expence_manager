import '../constants/records.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import 'package:expence_manager/widgets/tab_bar.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/custom_expense_card.dart'; // Import the CustomExpenseCard

class TotalExpense extends StatelessWidget {
  const TotalExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            topbar(
              title: 'Total Expense',
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  // Add your leading button functionality here
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Add your trailing button functionality here
                },
              ),
            ),
            TimelineCalender(), // Timeline calendar
            CustomContainer(), // Circular container
            Container(
              height: 400.0, // Set an appropriate height for the tab bar section
              child: CustomTabBar(
                tabs: [
                  Tab(text: 'Spends'),
                  Tab(text: 'Category'),
                ],
                tabViews: [
                  // Use the recordWidget with dynamic data
                  recordWidget(records),
                  CustomExpenseCard(),
                  // Display the expense card in the "Category" tab
                ],
              ),
            ),
            // Add the rest of your TotalExpense widget content here
          ],
        ),
      ),
    );
  }
}
