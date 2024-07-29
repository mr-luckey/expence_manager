import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:expence_manager/Controllers/total_controller.dart';
import 'package:expence_manager/Views/Add_Expense.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:expence_manager/Views/expense_detail_screen.dart';
import 'package:expence_manager/Views/income_detail_screen.dart';
import 'package:expence_manager/Views/total_detail_screen.dart';
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
import '../Models/income_model.dart';
import '../Models/income_model_adapter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, BuildContext? initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final incomeController = Get.put(IncomeController());
  final expenseController = Get.put(ExpenseController());
  final totalController = Get.put(TotalController());

  // Boolean to control the visibility of combined latest entries
  bool showCombinedEntries = false;

  @override
  void initState() {
    super.initState();
    incomeController.openHiveBox();
    expenseController.openHiveBox();
    totalController.openHiveBox();
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
                          'Category: ${income?.category.toString() ?? ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          'Date: ${income != null ? DateFormat.yMd().format(income.dateTime) : ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),

                      ],
                    ),
                    // Text(
                    //   '  ${income?.type.toString() ?? ''}',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //   ),
                    // ),
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
                          'Date: ${expense != null ? DateFormat.yMd().format(expense.dateTime) : ''}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   'type: ${expense?.type.toString() ?? ''}',
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //   ),
                    // ),
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

  // Method to build the combined list of latest entries
  Widget _buildCombinedList() {
    List<dynamic> combinedList = [];
    combinedList.addAll(incomeController.incomeBox!.values);
    combinedList.addAll(expenseController.expenseBox!.values);

    combinedList.sort((a, b) => b.dateTime.compareTo(a.dateTime)); // Sorting by date

    return ListView.builder(
      itemCount: combinedList.length,
      itemBuilder: (context, index) {
        final entry = combinedList[index];
        bool isIncome = entry is IncomeModel;

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
                      entry.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Amount: ${entry.amount ?? ''}',
                      style: TextStyle(
                        color: isIncome ? Colors.green : Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${entry.description ?? ''}',
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
                      'Category: ${entry.category?.toString() ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Date: ${entry != null ? DateFormat.yMd().format(entry.dateTime) : ''}',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Type: ${isIncome ? 'Income' : 'Expense'}', // Added type visibility
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (isIncome) {
                        incomeController.deleteIncome(index, context);
                      } else {
                        expenseController.deleteExpense(index, context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
                        incomeController.showIncome.value ? 'Total Income' : incomeController.showTotal.value ? 'Total' : 'Total Expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Set text color to black
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '\$${(incomeController.showIncome.value ? incomeController.totalAmount : incomeController.showTotal.value ? incomeController.remainingBalance : incomeController.totalExpense).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: incomeController.showIncome.value ? Colors.green : Colors.red,
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
                          incomeController.showIncome = true.obs;
                          incomeController.showTotal = false.obs;
                          showCombinedEntries = false;
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
                          incomeController.showIncome = false.obs;
                          incomeController.showTotal = false.obs;
                          showCombinedEntries = false;
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
                          incomeController.showTotal = true.obs;
                          incomeController.showIncome = false.obs;
                          showCombinedEntries = true;
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
                      if (showCombinedEntries) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TotalDetailScreen()));
                      } else if (incomeController.showIncome.value) {
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
                child: showCombinedEntries ? _buildCombinedList() : incomeController.showIncome.value ? _buildIncomeList() : _buildExpenseList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
