import 'package:expence_manager/Controllers/Total_controller.dart';
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
  var totalController = Get.put(TotalController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    totalController.fetchIncomeData();
    totalController.fetchExpenseData();
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
      if (totalController.expenseList.isEmpty && totalController.incomeList.isEmpty) {
        return Center(child: Text('No Entries'));
      }
      return ListView(
        children: [
          _buildSectionHeader('Income'),
          ...totalController.incomeList.map((income) => _buildIncomeTile(income)),
          _buildSectionHeader('Expenses'),
          ...totalController.expenseList.map((expense) => _buildExpenseTile(expense)),
        ],
      );
    });
  }

  Widget _buildWeeklyView() {
    return Obx(() {
      if (totalController.expenseList.isEmpty && totalController.incomeList.isEmpty) {
        return Center(child: Text('No Entries'));
      }
      return ListView(
        children: [
          _buildSectionHeader('Income'),
          ...totalController.incomeList.map((income) => _buildIncomeTile(income)),
          _buildSectionHeader('Expenses'),
          ...totalController.expenseList.map((expense) => _buildExpenseTile(expense)),
        ],
      );
    });
  }

  Widget _buildMonthlyView() {
    return Obx(() {
      if (totalController.expenseList.isEmpty && totalController.incomeList.isEmpty) {
        return Center(child: Text('No Entries'));
      }
      return ListView(
        children: [
          _buildSectionHeader('Income'),
          ...totalController.incomeList.map((income) => _buildIncomeTile(income)),
          _buildSectionHeader('Expenses'),
          ...totalController.expenseList.map((expense) => _buildExpenseTile(expense)),
        ],
      );
    });
  }

  Widget _buildYearlyView() {
    return Obx(() {
      if (totalController.expenseList.isEmpty && totalController.incomeList.isEmpty) {
        return Center(child: Text('No Entries'));
      }
      return ListView(
        children: [
          _buildSectionHeader('Income'),
          ...totalController.incomeList.map((income) => _buildIncomeTile(income)),
          _buildSectionHeader('Expenses'),
          ...totalController.expenseList.map((expense) => _buildExpenseTile(expense)),
        ],
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
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => totalController.deleteExpense(totalController.expenseList.indexOf(expense), context),
      ),
    );
  }
}
