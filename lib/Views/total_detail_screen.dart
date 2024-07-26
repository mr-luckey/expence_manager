import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Controllers/Income_controller.dart';
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
  final IncomeController incomeController = Get.put(IncomeController());
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    incomeController.fetchIncomeData();
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
            borderRadius: BorderRadius.circular(50),
            color: Colors.blueAccent,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
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
      if (incomeController.incomeList.isEmpty && expenseController.expenseList.isEmpty) {
        return Center(child: Text('No Entries'));
      }

      return ListView(
        children: [
          ...incomeController.incomeList.map((income) => _buildIncomeItem(income)).toList(),
          ...expenseController.expenseList.map((expense) => _buildExpenseItem(expense)).toList(),
        ],
      );
    });
  }

  Widget _buildWeeklyView() {
    // Implement weekly view combining income and expense data
    return Center(child: Text('Weekly Income and Expense Details'));
  }

  Widget _buildMonthlyView() {
    // Implement monthly view combining income and expense data
    return Center(child: Text('Monthly Income and Expense Details'));
  }

  Widget _buildYearlyView() {
    // Implement yearly view combining income and expense data
    return Center(child: Text('Yearly Income and Expense Details'));
  }

  Widget _buildIncomeItem(dynamic income) {
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
                  income.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Amount: ${income.amount ?? ''}',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'Description: ${income.description ?? ''}',
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
                  'Category: ${income.categoryIndex.toString() ?? ''}',
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
                onPressed: () => incomeController.deleteIncome(incomeController.incomeList.indexOf(income), context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseItem(dynamic expense) {
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
                  expense.title ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Amount: ${expense.amount ?? ''}',
                  style: TextStyle(
                    color: Colors.red,
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
                onPressed: () => expenseController.deleteExpense(expenseController.expenseList.indexOf(expense), context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
