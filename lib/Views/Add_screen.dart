import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:expence_manager/Views/add_expense.dart'; // Import the AddExpensePage
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import '../constants/records.dart';
import '../widgets/record_widget.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _selectedIndex = -1;

  void _onContainerTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              AddIncome(), // Navigate to AddIncome for index 1
        ),
      );
    } else if (index == 2) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              AddExpense(), // Navigate to AddExpense for index 2
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: "Add Page", // Set your title here
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _onContainerTap(index),
                      child: Container(
                        height: 70, // Increased height
                        width: 70, // Increased width
                        decoration: BoxDecoration(
                          // color: _selectedIndex == index ? Colors.blue : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: _buildContainerContent(index),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: const Text(
                    "Latest Entries",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black45),
                  ),
                  child: Center(child: Icon(Icons.more_vert_rounded)),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: double.infinity,
                child: recordWidget(records, dark),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContainerContent(int index) {
    if (index == 0) {
      return Center(
        child: Icon(
          Icons.add,
          // color: _selectedIndex == index ? Colors.white : Colors.black,
        ),
      );
    } else if (index == 1) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet,
            // color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
          Text(
            'Add Income',
            style: TextStyle(
              // color: _selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet,
            // color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
          Text(
            'Add Expense',
            style: TextStyle(
              // color: _selectedIndex == index ? Colors.white : Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      );
    }
  }
}
