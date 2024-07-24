import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/Views/total_Expense.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/intl.dart';

import '../Models/expense_model.dart';
import '../Models/expense_model_adapter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, BuildContext? initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<IncomeModel>? _incomeBox;
  Box<ExpenseModel>? _expenseBox;
  bool _isBoxOpened = false;
  double totalAmount = 0;
  double totalExpense = 0;
  double remainingBalance = 0;
  bool showIncome = true;
  bool showTotal = false;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  @override
  void dispose() {
    Hive.close(); // Close all Hive boxes when the app is terminated
    super.dispose();
  }

  Future<void> _openHiveBox() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter

    // Register adapters for models
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IncomeModelAdapter()); // Register IncomeModel adapter
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ExpenseModelAdapter()); // Register ExpenseModel adapter
    }

    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path); // Initialize Hive with the app's document directory

    _incomeBox = await Hive.openBox<IncomeModel>('incomes');
    _expenseBox = await Hive.openBox<ExpenseModel>('expenses');

    _calculateTotalIncome(); // Calculate the initial total income
    _calculateTotalExpense(); // Calculate the initial total expense
    _calculateRemainingBalance(); // Calculate the initial remaining balance

    setState(() {
      _isBoxOpened = true; // Set a flag to indicate the box is opened, if necessary
    });
  }

  void _calculateTotalIncome() {
    totalAmount = 0;
    if (_incomeBox != null) {
      for (var income in _incomeBox!.values) {
        totalAmount += double.parse(income.amount);
      }
    }
    print('Total income: \$${totalAmount.toStringAsFixed(2)}');
  }

  void _calculateTotalExpense() {
    totalExpense = 0;
    if (_expenseBox != null) {
      for (var expense in _expenseBox!.values) {
        if (expense.amount is String) {
          totalExpense += double.parse(expense.amount as String);
        } else if (expense.amount is double) {
          totalExpense += expense.amount as double;
        } else {
          print('Invalid amount type for expense: ${expense.amount.runtimeType}');
        }
      }
    }
    print('Total expense: \$${totalExpense.toStringAsFixed(2)}');
  }

  void _calculateRemainingBalance() {
    remainingBalance = totalAmount - totalExpense;
    print('Remaining balance: \$${remainingBalance.toStringAsFixed(2)}');
  }

  Future<void> _deleteIncome(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Income'),
          content: Text('Are you sure you want to delete this income entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                _incomeBox?.deleteAt(index);
                _calculateTotalIncome();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      setState(() {}); // Refresh the UI after deletion
    }
  }

  Future<void> _deleteExpense(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                _expenseBox?.deleteAt(index);
                _calculateTotalExpense();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      setState(() {}); // Refresh the UI after deletion
    }
  }

  Future<void> _addIncome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncome()),
    );
    _calculateTotalIncome(); // Recalculate the total income after adding a new entry
    setState(() {}); // Refresh the state when coming back to HomeScreen
  }

  Future<void> _addExpense() async {
    // Implement navigation to add expense screen
    // Similar to _addIncome()
  }

  Widget _buildIncomeList() {
    return _incomeBox != null
        ? _incomeBox!.isOpen
        ? ValueListenableBuilder(
      valueListenable: _incomeBox!.listenable(),
      builder: (context, Box<IncomeModel> box, _) {
        if (box.values.isEmpty) {
          return Center(
            child: Text(
              'No income entries',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final income = box.getAt(index);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          income?.title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Amount: ${income?.amount ?? ''}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Description: ${income?.description ?? ''}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category: ${income?.categoryIndex.toString() ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Date: ${income != null ? DateFormat.yMd().format(income.datetime) : ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => _deleteIncome(index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    )
        : Center(
      child: CircularProgressIndicator(),
    )
        : CircularProgressIndicator();
  }

  Widget _buildExpenseList() {
    return _expenseBox != null
        ? _expenseBox!.isOpen
        ? ValueListenableBuilder(
      valueListenable: _expenseBox!.listenable(),
      builder: (context, Box<ExpenseModel> box, _) {
        if (box.values.isEmpty) {
          return Center(
            child: Text(
              'No expense entries',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final expense = box.getAt(index);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          expense?.title ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          'Amount: ${expense?.amount ?? ''}',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Description: ${expense?.description ?? ''}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Category: ${expense?.category.toString() ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Date: ${expense != null ? DateFormat.yMd().format(expense.date) : ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () => _deleteExpense(index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    )
        : Center(
      child: CircularProgressIndicator(),
    )
        : CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addIncome,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Overview',
              isDark: dark,
              onBackPressed: () {
                Get.back();
              },
            ),
            SizedBox(
              height: Get.height / 300,
            ),
            // Card to display total amount
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white, // Set background color to white
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        showIncome ? 'Total Income' : showTotal ? 'Total' : 'Total Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to black
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$${(showIncome ? totalAmount : showTotal ? remainingBalance : totalExpense).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: showIncome ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: Get.height / 50,
            ),
            Container(
              height: Get.height * 0.06,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Btn(
                      isdark: dark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SavingPage()),
                        );
                      },
                      text: 'Saving',
                      iconData: Icons.add,
                      index: 0,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReminderPage()),
                        );
                      },
                      text: 'Remind',
                      iconData: Icons.notifications_active_outlined,
                      index: 1,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {},
                      text: 'Budget',
                      iconData: Icons.savings_outlined,
                      index: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Entries",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black), // Set text color to black
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.black), // Set border color to black
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TotalExpense()));
                      },
                      child: Center(
                          child: Icon(Icons.more_vert_rounded,
                              color: Colors.black)), // Set icon color to black
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 400,
                width: double.infinity,
                child: showIncome ? _buildIncomeList() : _buildExpenseList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
