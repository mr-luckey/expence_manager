import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/widgets/custom_catagory_card.dart';
import 'package:flutter/material.dart';
import 'package:expence_manager/widgets/container.dart';
import 'package:expence_manager/widgets/record_widget.dart';
import 'package:expence_manager/widgets/tab_bar.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:expence_manager/widgets/Topbar.dart';

class TotalExpense extends StatelessWidget {
  const TotalExpense({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    // Sample data for the CustomCategoryCard
    final List<double> expenses = [300, 150, 100, 50];
    final List<String> labels = [
      'Rent',
      'Groceries',
      'Utilities',
    ];
    final List<Color> colors = [
      Colors.blue.shade300,
      Colors.blue.shade400,
      Colors.blue.shade700,
      Colors.blue.shade900
    ];
    final List<Map<String, dynamic>> records = [
      {
        'iconData': Icons.home,
        'title': 'Home Payment',
        'dateTime': '2024-06-07',
        'symbols': '\$',
        'amount': 1000,
        'paymentMethod': 'Credit Card',
      },
      {
        'iconData': Icons.star,
        'title': 'Star Payment',
        'dateTime': '2024-06-06 ',
        'symbols': '\$',
        'amount': 200,
        'paymentMethod': 'PayPal',
      },
      {
        'iconData': Icons.settings,
        'title': 'Settings Payment',
        'dateTime': '2024-06-05 ',
        'symbols': '\$',
        'amount': 300,
        'paymentMethod': 'Debit Card',
      },
      {
        'iconData': Icons.shopping_cart,
        'title': 'Shopping Payment',
        'dateTime': '2024-06-04 ',
        'symbols': '\$',
        'amount': 150,
        'paymentMethod': 'Cash',
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // topbar(
            //   title: 'Total Expense',
            //   leading: IconButton(
            //     icon: Icon(Icons.menu),
            //     onPressed: () {
            //       // Add your leading button functionality here
            //     },
            //   ),
            //   trailing: IconButton(
            //     icon: Icon(Icons.add),
            //     onPressed: () {
            //       // Add your trailing button functionality here
            //     },
            //   ),
            // ),
            TimelineCalender(), // Timeline calendar
            CustomContainer(), // Circular container
            Container(
              height:
                  400.0, // Set an appropriate height for the tab bar section
              child: CustomTabBar(
                tabs: [
                  Tab(text: 'Spends'),
                  Tab(text: 'Category'),
                ],
                tabViews: [
                  recordWidget(
                      records, dark), // Use the recordWidget with dynamic data
                  CustomCategoryCard(
                    expenses: expenses,
                    labels: labels,
                    colors: colors,
                    records: records,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
