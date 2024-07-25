import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class IncomeDetailScreen extends StatefulWidget {
  const IncomeDetailScreen({super.key});

  @override
  State<IncomeDetailScreen> createState() => _IncomeDetailScreenState();
}

class _IncomeDetailScreenState extends State<IncomeDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final IncomeController _incomeController = Get.find(); // Get the controller
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
          labelColor: Colors.black, // Text color when tab is selected
          unselectedLabelColor: Colors.white, // Text color when tab is not selected
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
      if (incomeController.incomeList.isEmpty) {
        return Center(child: Text('No Income Entries'));
      }
      else{
        // Filter income data for daily view
        // Assuming you have a way to filter the data by date
        return ListView.builder(
          itemCount: incomeController.incomeList.length,
          itemBuilder: (context, index) {
            final income = incomeController.incomeList[index];
            return Column(
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
                    onPressed: () => incomeController.deleteIncome(index, context),
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
    // Implement weekly view
    return Center(child: Text('Weekly Income Details'));
  }

  Widget _buildMonthlyView() {
    // Implement monthly view
    return Center(child: Text('Monthly Income Details'));
  }

  Widget _buildYearlyView() {
    // Implement yearly view
    return Center(child: Text('Yearly Income Details'));
  }
}
