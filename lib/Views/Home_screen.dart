import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Add_Expense.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:expence_manager/Views/expense_detail_screen.dart';
import 'package:expence_manager/Views/income_detail_screen.dart';
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
  final incomeController = Get.put(IncomeController());
  final expenseController = Get.put(ExpenseController());

  @override
  void initState() {
    super.initState();
    incomeController.openHiveBox();
    expenseController.openHiveBox();
  }

  @override
  void dispose() {
    Hive.close(); // Close all Hive boxes when the app is terminated
    super.dispose();
  }

  Widget _buildIncomeList() {
    return incomeController.incomeBox != null
        ? incomeController.incomeBox!.isOpen
        ? ValueListenableBuilder(
      valueListenable: incomeController.incomeBox!.listenable(),
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
                        onPressed: () => incomeController.deleteIncome(index, context),
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
    return expenseController.expenseBox != null
        ? expenseController.expenseBox!.isOpen
        ? ValueListenableBuilder(
      valueListenable: expenseController.expenseBox!.listenable(),
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
                        onPressed: () => expenseController.deleteExpense(index, context),
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
            onPressed: () {
              incomeController.addIncome(context);
            },
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
                        incomeController.showIncome ? 'Total Income' : incomeController.showTotal ? 'Total' : 'Total Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to black
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$${(incomeController.showIncome ? incomeController.totalAmount : incomeController.showTotal ? incomeController.remainingBalance : incomeController.totalExpense).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: incomeController.showIncome ? Colors.green : Colors.red,
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
                        setState(() {
                          incomeController.showIncome = true;
                          incomeController.showTotal = false;
                        });
                      },
                      text: 'Income',
                      iconData: Icons.add,
                      index: 0,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {
                        setState(() {
                          incomeController.showIncome = false;
                          incomeController.showTotal = false;
                        });
                      },
                      text: 'Expense',
                      iconData: Icons.notifications_active_outlined,
                      index: 1,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {
                        setState(() {
                          incomeController.showTotal = true;
                          incomeController.showIncome = false;
                        });
                      },
                      text: 'Total',
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
                  GestureDetector(
                    onTap: () {
                      if (incomeController.showIncome) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => IncomeDetailScreen()));
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ExpenseDetailScreen()));
                      }
                    },
                    child: Text(
                      "Latest Entries",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black), // Set text color to black
                    ),
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
                child: incomeController.showIncome ? _buildIncomeList() : _buildExpenseList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
