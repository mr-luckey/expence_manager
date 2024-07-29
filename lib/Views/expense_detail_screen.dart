import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExpenseDetailScreen extends StatefulWidget {
  const ExpenseDetailScreen({super.key});

  @override
  State<ExpenseDetailScreen> createState() => _ExpenseDetailScreenState();
}

class _ExpenseDetailScreenState extends State<ExpenseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
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
            borderRadius: BorderRadius.circular(50),
            color: Colors.blueAccent,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.tab,
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
      DateTime today = DateTime.now();

      List<ExpenseModel> dailyExpenses = expenseController.expenseList.where((expense) {
        return isSameDay(expense.dateTime, today);
      }).toList();

      if (dailyExpenses.isEmpty) {
        return Center(child: Text('No Expense Entries for Today'));
      }

      return _buildExpenseList(dailyExpenses);
    });
  }

  Widget _buildWeeklyView() {
    return Obx(() {
      DateTime now = DateTime.now();

      List<ExpenseModel> weeklyExpenses = expenseController.expenseList.where((expense) {
        return isSameWeek(expense.dateTime, now);
      }).toList();

      if (weeklyExpenses.isEmpty) {
        return Center(child: Text('No Expense Entries This Week'));
      }

      return _buildExpenseList(weeklyExpenses);
    });
  }

  Widget _buildMonthlyView() {
    return Obx(() {
      DateTime now = DateTime.now();

      List<ExpenseModel> monthlyExpenses = expenseController.expenseList.where((expense) {
        return isSameMonth(expense.dateTime, now);
      }).toList();

      if (monthlyExpenses.isEmpty) {
        return Center(child: Text('No Expense Entries This Month'));
      }

      return _buildExpenseList(monthlyExpenses);
    });
  }

  Widget _buildYearlyView() {
    return Obx(() {
      DateTime now = DateTime.now();

      List<ExpenseModel> yearlyExpenses = expenseController.expenseList.where((expense) {
        return isSameYear(expense.dateTime, now);
      }).toList();

      if (yearlyExpenses.isEmpty) {
        return Center(child: Text('No Expense Entries This Year'));
      }

      return _buildExpenseList(yearlyExpenses);
    });
  }

  Widget _buildExpenseList(List<ExpenseModel> expenses) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final expense = expenses[index];

        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Amount: ${expense.amount}',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${expense.description}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Category: ${expense.category}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Date: ${DateFormat.yMd().format(expense.dateTime)}',
                  style: TextStyle(
                    fontSize: 14,
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
                      expenseController.deleteExpense(index, context);
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

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool isSameWeek(DateTime date1, DateTime date2) {
    final startOfWeek = date1.subtract(Duration(days: date1.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    return date2.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        date2.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  bool isSameYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year;
  }
}
