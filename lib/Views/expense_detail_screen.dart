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
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 1;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

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

  void showCalendarDialog(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(3000),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expense Details'),
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => showCalendarDialog(context),
            ),
          ],
        ),
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
    return Expanded(
      child: Obx(() {
        List<ExpenseModel> dailyExpenses = expenseController.expenseList.where((expense) {
          return isSameDay(expense.dateTime, selectedDate);
        }).toList();

        if (dailyExpenses.isEmpty) {
          return Center(child: Text('No Expense Entries for Selected Date'));
        }

        return _buildExpenseList(dailyExpenses);
      }),
    );
  }

  Widget _buildWeeklyView() {
    return Expanded(
      child: Obx(() {
        List<ExpenseModel> weeklyExpenses = expenseController.expenseList.where((expense) {
          return isSameWeek(expense.dateTime, selectedDate, selectedWeek);
        }).toList();

        if (weeklyExpenses.isEmpty) {
          return Center(child: Text('No Expense Entries for Selected Week'));
        }

        return _buildExpenseList(weeklyExpenses);
      }),
    );
  }

  Widget _buildMonthlyView() {
    return Expanded(
      child: Obx(() {
        List<ExpenseModel> monthlyExpenses = expenseController.expenseList.where((expense) {
          return isSameMonth(expense.dateTime, selectedDate, selectedMonth);
        }).toList();

        if (monthlyExpenses.isEmpty) {
          return Center(child: Text('No Expense Entries for Selected Month'));
        }

        return _buildExpenseList(monthlyExpenses);
      }),
    );
  }

  Widget _buildYearlyView() {
    return Expanded(
      child: Obx(() {
        List<ExpenseModel> yearlyExpenses = expenseController.expenseList.where((expense) {
          return isSameYear(expense.dateTime, selectedDate, selectedYear);
        }).toList();

        if (yearlyExpenses.isEmpty) {
          return Center(child: Text('No Expense Entries for Selected Year'));
        }

        return _buildExpenseList(yearlyExpenses);
      }),
    );
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

  bool isSameWeek(DateTime date1, DateTime date2, int week) {
    final startOfWeek = date2.subtract(Duration(days: date2.weekday - 1));
    final targetWeekStart = startOfWeek.add(Duration(days: (week - 1) * 7));
    final targetWeekEnd = targetWeekStart.add(Duration(days: 6));
    return date1.isAfter(targetWeekStart.subtract(Duration(days: 1))) &&
        date1.isBefore(targetWeekEnd.add(Duration(days: 1)));
  }

  bool isSameMonth(DateTime date1, DateTime date2, int month) {
    return date1.year == date2.year && date1.month == month;
  }

  bool isSameYear(DateTime date1, DateTime date2, int year) {
    return date1.year == year;
  }
}
