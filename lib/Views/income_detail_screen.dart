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
  DateTime selectedDate = DateTime.now();
  int selectedWeek = 1;
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;

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
            Text('Income Details'),
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
        List<IncomeModel> dailyIncomes = incomeController.incomeList.where((income) {
          return isSameDay(income.dateTime, selectedDate);
        }).toList();

        if (dailyIncomes.isEmpty) {
          return Center(child: Text('No Income Entries for Selected Date'));
        }

        return _buildIncomeList(dailyIncomes);
      }),
    );
  }

  Widget _buildWeeklyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> weeklyIncomes = incomeController.incomeList.where((income) {
          return isSameWeek(income.dateTime, selectedDate, selectedWeek);
        }).toList();

        if (weeklyIncomes.isEmpty) {
          return Center(child: Text('No Income Entries for Selected Week'));
        }

        return _buildIncomeList(weeklyIncomes);
      }),
    );
  }

  Widget _buildMonthlyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> monthlyIncomes = incomeController.incomeList.where((income) {
          return isSameMonth(income.dateTime, selectedDate, selectedMonth);
        }).toList();

        if (monthlyIncomes.isEmpty) {
          return Center(child: Text('No Income Entries for Selected Month'));
        }

        return _buildIncomeList(monthlyIncomes);
      }),
    );
  }

  Widget _buildYearlyView() {
    return Expanded(
      child: Obx(() {
        List<IncomeModel> yearlyIncomes = incomeController.incomeList.where((income) {
          return isSameYear(income.dateTime, selectedDate, selectedYear);
        }).toList();

        if (yearlyIncomes.isEmpty) {
          return Center(child: Text('No Income Entries for Selected Year'));
        }

        return _buildIncomeList(yearlyIncomes);
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
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      incomeController.deleteIncome(index, context);
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
