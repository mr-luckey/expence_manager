import 'package:expence_manager/Controllers/total_controller.dart';
import 'package:expence_manager/Models/expense_model.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalDetailScreen extends StatefulWidget {
  const TotalDetailScreen({super.key});

  @override
  State<TotalDetailScreen> createState() => _TotalDetailScreenState();
}

class _TotalDetailScreenState extends State<TotalDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TotalController totalController = Get.put(TotalController());
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 1;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    totalController.openHiveBox().then((_) {
      setState(() {}); // Ensure the state is updated after fetching data
    });
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
            Text('Total Details'),
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
        List<IncomeModel> dailyIncomes = totalController.incomeList.where((income) {
          return isSameDay(income.dateTime, selectedDate);
        }).toList();
        List<ExpenseModel> dailyExpenses = totalController.expenseList.where((expense) {
          return isSameDay(expense.dateTime, selectedDate);
        }).toList();

        if (dailyIncomes.isEmpty && dailyExpenses.isEmpty) {
          return Center(child: Text('No Entries for Selected Date'));
        }

        return Column(
          children: [
            Expanded(child: _buildIncomeList(dailyIncomes)),
            Expanded(child: _buildExpenseList(dailyExpenses)),
          ],
        );
      }),
    );
  }

  Widget _buildWeeklyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> weeklyIncomes = totalController.incomeList.where((income) {
          return isSameWeek(income.dateTime, selectedDate, selectedWeek);
        }).toList();
        List<ExpenseModel> weeklyExpenses = totalController.expenseList.where((expense) {
          return isSameWeek(expense.dateTime, selectedDate, selectedWeek);
        }).toList();

        if (weeklyIncomes.isEmpty && weeklyExpenses.isEmpty) {
          return Center(child: Text('No Entries for Selected Week'));
        }

        return Column(
          children: [
            Expanded(child: _buildIncomeList(weeklyIncomes)),
            Expanded(child: _buildExpenseList(weeklyExpenses)),
          ],
        );
      }),
    );
  }

  Widget _buildMonthlyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> monthlyIncomes = totalController.incomeList.where((income) {
          return isSameMonth(income.dateTime, selectedDate, selectedMonth);
        }).toList();
        List<ExpenseModel> monthlyExpenses = totalController.expenseList.where((expense) {
          return isSameMonth(expense.dateTime, selectedDate, selectedMonth);
        }).toList();

        if (monthlyIncomes.isEmpty && monthlyExpenses.isEmpty) {
          return Center(child: Text('No Entries for Selected Month'));
        }

        return Column(
          children: [
            Expanded(child: _buildIncomeList(monthlyIncomes)),
            Expanded(child: _buildExpenseList(monthlyExpenses)),
          ],
        );
      }),
    );
  }

  Widget _buildYearlyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> yearlyIncomes = totalController.incomeList.where((income) {
          return isSameYear(income.dateTime, selectedDate, selectedYear);
        }).toList();
        List<ExpenseModel> yearlyExpenses = totalController.expenseList.where((expense) {
          return isSameYear(expense.dateTime, selectedDate, selectedYear);
        }).toList();

        if (yearlyIncomes.isEmpty && yearlyExpenses.isEmpty) {
          return Center(child: Text('No Entries for Selected Year'));
        }

        return Column(
          children: [
            Expanded(child: _buildIncomeList(yearlyIncomes)),
            Expanded(child: _buildExpenseList(yearlyExpenses)),
          ],
        );
      }),
    );
  }

  Widget _buildIncomeList(List<IncomeModel> incomes) {
    return ListView.builder(
      itemCount: incomes.length,
      itemBuilder: (context, index) {
        final income = incomes[index];

        return Card(
          margin: EdgeInsets.all(8.0),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  income.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Amount: ${income.amount}',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Description: ${income.description}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Category: ${income.category}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Date: ${DateFormat.yMd().format(income.dateTime)}',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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