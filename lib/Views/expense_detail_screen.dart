import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class ExpenseDetailScreen extends StatefulWidget {
  const ExpenseDetailScreen({super.key});

  @override
  State<ExpenseDetailScreen> createState() => _IncomeDetailScreenState();
}

class _IncomeDetailScreenState extends State<ExpenseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final IncomeController _incomeController = Get.find(); // Get the controller
  var incomeController = Get.put(IncomeController());
  var expenseController = Get.put(ExpenseController());


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    expenseController.fetchExpenseData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Daily'),
            Tab(text: 'Weekly'),
            Tab(text: 'Monthly'),
            Tab(text: 'Yearly'),
          ],
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50), // Creates rounded rectangle
            color: Colors.blueAccent, // Changes indicator color
          ),
          labelColor: Colors.white, // Text color when tab is selected
          unselectedLabelColor: Colors.black, // Text color when tab is not selected
          indicatorSize: TabBarIndicatorSize.tab, // Makes indicator the size of the tab
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDailyView(),
          _buildWeeklyView(),
          _buildMonthlyView(),
          _buildYearlyView(),
        ],
      ),
    );
  }

  Widget _buildDailyView() {
    return Obx(() {
      if (expenseController.expenseList.isEmpty) {
        return Center(child: Text('No Expense Entries'));
      }
      else{
        // Filter income data for daily view
        // Assuming you have a way to filter the data by date
        return ListView.builder(
          itemCount: expenseController.expenseList.length,
          itemBuilder: (context, index) {
            final expense = expenseController.expenseList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Amount: ${expense.amount ?? ''}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${expense.description ?? ''}',
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
                      'Category: ${expense.category.toString() ?? ''}',
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => expenseController.deleteIncome(index, context),
                  ),
                ),
              ],
            );
          },
        );
      }

      // Filter income data for daily view
      // Assuming you have a way to filter the data by date
      return ListView.builder(
        itemCount: incomeController.incomeList.length,
        itemBuilder: (context, index) {
          final income = incomeController.incomeList[index];
          return ListTile(
            title: Text(income.title ?? ''),
            subtitle: Text('\$${income.amount}'),
          );
        },
      );
    });
  }

  Widget _buildWeeklyView() {
    return Obx(() {
      if (expenseController.expenseList.isEmpty) {
        return Center(child: Text('No Expense Entries'));
      }
      else{
        // Filter income data for daily view
        // Assuming you have a way to filter the data by date
        return ListView.builder(
          itemCount: expenseController.expenseList.length,
          itemBuilder: (context, index) {
            final expense = expenseController.expenseList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Amount: ${expense.amount ?? ''}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${expense.description ?? ''}',
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
                      'Category: ${expense.category.toString() ?? ''}',
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => expenseController.deleteIncome(index, context),
                  ),
                ),
              ],
            );
          },
        );
      }

      // Filter income data for daily view
      // Assuming you have a way to filter the data by date
      return ListView.builder(
        itemCount: incomeController.incomeList.length,
        itemBuilder: (context, index) {
          final income = incomeController.incomeList[index];
          return ListTile(
            title: Text(income.title ?? ''),
            subtitle: Text('\$${income.amount}'),
          );
        },
      );
    });
  }

  Widget _buildMonthlyView() {
    return Obx(() {
      if (expenseController.expenseList.isEmpty) {
        return Center(child: Text('No Expense Entries'));
      }
      else{
        // Filter income data for daily view
        // Assuming you have a way to filter the data by date
        return ListView.builder(
          itemCount: expenseController.expenseList.length,
          itemBuilder: (context, index) {
            final expense = expenseController.expenseList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Amount: ${expense.amount ?? ''}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${expense.description ?? ''}',
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
                      'Category: ${expense.category.toString() ?? ''}',
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => expenseController.deleteIncome(index, context),
                  ),
                ),
              ],
            );
          },
        );
      }

      // Filter income data for daily view
      // Assuming you have a way to filter the data by date
      return ListView.builder(
        itemCount: incomeController.incomeList.length,
        itemBuilder: (context, index) {
          final income = incomeController.incomeList[index];
          return ListTile(
            title: Text(income.title ?? ''),
            subtitle: Text('\$${income.amount}'),
          );
        },
      );
    });
  }

  Widget _buildYearlyView() {
    return Obx(() {
      if (expenseController.expenseList.isEmpty) {
        return Center(child: Text('No Expense Entries'));
      }
      else{
        // Filter income data for daily view
        // Assuming you have a way to filter the data by date
        return ListView.builder(
          itemCount: expenseController.expenseList.length,
          itemBuilder: (context, index) {
            final expense = expenseController.expenseList[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.title ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Amount: ${expense.amount ?? ''}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${expense.description ?? ''}',
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
                      'Category: ${expense.category.toString() ?? ''}',
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () => expenseController.deleteIncome(index, context),
                  ),
                ),
              ],
            );
          },
        );
      }

      // Filter income data for daily view
      // Assuming you have a way to filter the data by date
      return ListView.builder(
        itemCount: incomeController.incomeList.length,
        itemBuilder: (context, index) {
          final income = incomeController.incomeList[index];
          return ListTile(
            title: Text(income.title ?? ''),
            subtitle: Text('\$${income.amount}'),
          );
        },
      );
    });
  }
}
