import 'package:expence_manager/Models/expense_model.dart';
import 'package:expence_manager/Models/expense_model_adapter.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Models/total_Model.dart';
import 'package:expence_manager/Views/Add_Expense.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/income_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:expence_manager/Controllers/total_controller.dart';

class TotalController extends GetxController {
  var incomeList = <IncomeModel>[].obs;
  var expenseList = <ExpenseModel>[].obs;
  var combinedList = <dynamic>[].obs;
  Box<IncomeModel>? incomeBox;
  Box<ExpenseModel>? expenseBox;
  double totalAmount = 0;
  double totalExpense = 0;
  double remainingBalance = 0;

  @override
  void onInit() {
    super.onInit();
    fetchIncomeData();
    fetchExpenseData();
  }

  Future<void> fetchIncomeData() async {
    incomeBox = await Hive.openBox<IncomeModel>('incomes');
    incomeList.value = incomeBox!.values.cast<IncomeModel>().toList();
    _calculateTotalIncome();
  }

  Future<void> fetchExpenseData() async {
    expenseBox = await Hive.openBox<ExpenseModel>('expenses');
    expenseList.value = expenseBox!.values.cast<ExpenseModel>().toList();
    _calculateTotalExpense();
  }
  List<dynamic> getCombinedList() {
    List<dynamic> combinedList = [];
    combinedList.addAll(incomeList);
    combinedList.addAll(expenseList);
    combinedList.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return combinedList;


  }

  Future<void> openHiveBox() async {
    await Hive.initFlutter();

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IncomeModelAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ExpenseModelAdapter());
    }

    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    incomeBox = await Hive.openBox<IncomeModel>('incomes');
    expenseBox = await Hive.openBox<ExpenseModel>('expenses');

    _calculateTotalIncome();
    _calculateTotalExpense();
    _calculateRemainingBalance();

    update();
  }

  void _calculateTotalIncome() {
    totalAmount = 0;
    if (incomeBox != null) {
      for (var income in incomeBox!.values) {
        totalAmount += double.parse(income.amount);
      }
    }
    print('Total income: \$${totalAmount.toStringAsFixed(2)}');
  }

  void _calculateTotalExpense() {
    totalExpense = 0;
    if (expenseBox != null) {
      for (var expense in expenseBox!.values) {
        if (expense.amount is String) {
          totalExpense += double.parse(expense.amount as String);
        } else if (expense.amount is double) {
          totalExpense += expense.amount as double;
        } else {
          print('Invalid amount type for expense: ${expense.amount.runtimeType}');
        }
      }
    }
    print('Total expense: \$${totalExpense.toStringAsFixed(2)}');
  }

  void _calculateRemainingBalance() {
    remainingBalance = totalAmount - totalExpense;
    print('Remaining balance: \$${remainingBalance.toStringAsFixed(2)}');
  }

  Future<void> deleteIncome(int index, BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Income'),
          content: Text('Are you sure you want to delete this income entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                incomeBox?.deleteAt(index);
                _calculateTotalIncome();
                _calculateRemainingBalance();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      update();
    }
  }

  Future<void> deleteExpense(int index, BuildContext context) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense entry?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                expenseBox?.deleteAt(index);
                _calculateTotalExpense();
                _calculateRemainingBalance();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      update();
    }
  }

  Future<void> addIncome(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncome()),
    );
    _calculateTotalIncome();
    _calculateRemainingBalance();
    update();
  }

  Future<void> addExpense(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpense()),
    );
    _calculateTotalExpense();
    _calculateRemainingBalance();
    update();
  }
}
