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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Total Details'),
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
      List<dynamic> combinedList = totalController.getCombinedList();
      if (combinedList.isEmpty) {
        return Center(child: Text('No Entries'));
      }

      DateTime today = DateTime.now();
      List<dynamic> todayList = combinedList.where((item) {
        DateTime itemDate = item.dateTime;
        return itemDate.year == today.year &&
            itemDate.month == today.month &&
            itemDate.day == today.day;
      }).toList();

      if (todayList.isEmpty) {
        return Center(child: Text('No Entries for Today'));
      }

      todayList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return ListView(
        children: todayList.map((item) {
          if (item is IncomeModel) {
            return _buildIncomeTile(item);
          } else if (item is ExpenseModel) {
            return _buildExpenseTile(item);
          } else {
            return Container();
          }
        }).toList(),
      );
    });
  }


  Widget _buildWeeklyView() {
    return Obx(() {
      List<dynamic> combinedList = totalController.getCombinedList();
      DateTime now = DateTime.now();
      DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

      List<dynamic> weeklyList = combinedList.where((item) {
        DateTime itemDate = item.dateTime;
        return itemDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            itemDate.isBefore(endOfWeek.add(Duration(days: 1)));
      }).toList();

      if (weeklyList.isEmpty) {
        return Center(child: Text('No Entries for this Week'));
      }

      weeklyList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return ListView(
        children: weeklyList.map((item) {
          if (item is IncomeModel) {
            return _buildIncomeTile(item);
          } else if (item is ExpenseModel) {
            return _buildExpenseTile(item);
          } else {
            return Container();
          }
        }).toList(),
      );
    });
  }

  Widget _buildMonthlyView() {
    return Obx(() {
      List<dynamic> combinedList = totalController.getCombinedList();
      DateTime now = DateTime.now();
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

      List<dynamic> monthlyList = combinedList.where((item) {
        DateTime itemDate = item.dateTime;
        return itemDate.isAfter(startOfMonth.subtract(Duration(days: 1))) &&
            itemDate.isBefore(endOfMonth.add(Duration(days: 1)));
      }).toList();

      if (monthlyList.isEmpty) {
        return Center(child: Text('No Entries for this Month'));
      }

      monthlyList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return ListView(
        children: monthlyList.map((item) {
          if (item is IncomeModel) {
            return _buildIncomeTile(item);
          } else if (item is ExpenseModel) {
            return _buildExpenseTile(item);
          } else {
            return Container();
          }
        }).toList(),
      );
    });
  }

  Widget _buildYearlyView() {
    return Obx(() {
      List<dynamic> combinedList = totalController.getCombinedList();
      DateTime now = DateTime.now();
      DateTime startOfYear = DateTime(now.year, 1, 1);
      DateTime endOfYear = DateTime(now.year, 12, 31);

      List<dynamic> yearlyList = combinedList.where((item) {
        DateTime itemDate = item.dateTime;
        return itemDate.isAfter(startOfYear.subtract(Duration(days: 1))) &&
            itemDate.isBefore(endOfYear.add(Duration(days: 1)));
      }).toList();

      if (yearlyList.isEmpty) {
        return Center(child: Text('No Entries for this Year'));
      }

      yearlyList.sort((a, b) => a.dateTime.compareTo(b.dateTime));

      return ListView(
        children: yearlyList.map((item) {
          if (item is IncomeModel) {
            return _buildIncomeTile(item);
          } else if (item is ExpenseModel) {
            return _buildExpenseTile(item);
          } else {
            return Container();
          }
        }).toList(),
      );
    });
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildIncomeTile(IncomeModel income) {
    return ListTile(
      title: Text(income.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: \$${income.amount}'),
          Text('Date: ${DateFormat.yMd().format(income.dateTime)}'),
          Text('Type: Income'), // Added type visibility
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => totalController.deleteIncome(totalController.incomeList.indexOf(income), context),
      ),
    );
  }

  Widget _buildExpenseTile(ExpenseModel expense) {
    return ListTile(
      title: Text(expense.title ?? ''),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Amount: \$${expense.amount}'),
          Text('Description: ${expense.description ?? ''}'),
          Text('Category: ${expense.category.toString() ?? ''}'),
          Text('Date: ${DateFormat.yMd().format(expense.dateTime)}'),
          Text('Type: Expense'), // Added type visibility
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => totalController.deleteExpense(totalController.expenseList.indexOf(expense), context),
      ),
    );
  }
}
