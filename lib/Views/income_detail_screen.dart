import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:expence_manager/Models/income_model.dart';

class IncomeDetailScreen extends StatefulWidget {
  const IncomeDetailScreen({super.key});

  @override
  State<IncomeDetailScreen> createState() => _IncomeDetailScreenState();
}

class _IncomeDetailScreenState extends State<IncomeDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var incomeController = Get.put(IncomeController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    incomeController.fetchIncomeData();
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
        title: Text('Income Details'),
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
      List<IncomeModel> dailyIncomes = incomeController.incomeList.where((income) {
        return isSameDay(income.dateTime, DateTime.now());
      }).toList();

      if (dailyIncomes.isEmpty) {
        return Center(child: Text('No Income Entries'));
      }

      return _buildIncomeList(dailyIncomes);
    });
  }

  Widget _buildWeeklyView() {
    return Obx(() {
      List<IncomeModel> weeklyIncomes = incomeController.incomeList.where((income) {
        return isSameWeek(income.dateTime, DateTime.now());
      }).toList();

      if (weeklyIncomes.isEmpty) {
        return Center(child: Text('No Income Entries'));
      }

      return _buildIncomeList(weeklyIncomes);
    });
  }

  Widget _buildMonthlyView() {
    return Obx(() {
      List<IncomeModel> monthlyIncomes = incomeController.incomeList.where((income) {
        return isSameMonth(income.dateTime, DateTime.now());
      }).toList();

      if (monthlyIncomes.isEmpty) {
        return Center(child: Text('No Income Entries'));
      }

      return _buildIncomeList(monthlyIncomes);
    });
  }

  Widget _buildYearlyView() {
    return Obx(() {
      List<IncomeModel> yearlyIncomes = incomeController.incomeList.where((income) {
        return isSameYear(income.dateTime, DateTime.now());
      }).toList();

      if (yearlyIncomes.isEmpty) {
        return Center(child: Text('No Income Entries'));
      }

      return _buildIncomeList(yearlyIncomes);
    });
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
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  bool isSameWeek(DateTime date1, DateTime date2) {
    final startOfWeek1 = date1.subtract(Duration(days: date1.weekday - 1));
    final endOfWeek1 = startOfWeek1.add(Duration(days: 6));
    return date2.isAfter(startOfWeek1) && date2.isBefore(endOfWeek1);
  }

  bool isSameMonth(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month;
  }

  bool isSameYear(DateTime date1, DateTime date2) {
    return date1.year == date2.year;
  }
}
