import 'package:expence_manager/Models/expense_model.dart';
import 'package:expence_manager/Models/expense_model_adapter.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Add_Expense.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../Models/income_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ExpenseController extends GetxController {
  var incomeList = <IncomeModel>[].obs;
  var expenseList = <ExpenseModel>[].obs;
  Box<IncomeModel>? incomeBox;
  Box<ExpenseModel>? expenseBox;
  bool _isBoxOpened = false;
  double totalAmount = 0;
  double totalExpense = 0;
  double remainingBalance = 0;
  bool showIncome = true;
  bool showTotal = false;


  @override
  void onInit() {
    super.onInit();
    fetchExpenseData();
  }

  Future<void> fetchExpenseData() async {
    var box = await Hive.openBox<ExpenseModel>('expenses');
    expenseList.value = box.values.cast<ExpenseModel>().toList();

    print("TESTING EXPEnse");
    print(expenseList.first.title);
  }

  Future<void> openHiveBox() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter

    // Register adapters for models
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IncomeModelAdapter()); // Register IncomeModel adapter
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ExpenseModelAdapter()); // Register ExpenseModel adapter
    }

    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path); // Initialize Hive with the app's document directory

    incomeBox = await Hive.openBox<IncomeModel>('incomes');
    expenseBox = await Hive.openBox<ExpenseModel>('expenses');

    _calculateTotalIncome(); // Calculate the initial total income
    _calculateTotalExpense(); // Calculate the initial total expense
    _calculateRemainingBalance(); // Calculate the initial remaining balance

    // setState(() {
    //   _isBoxOpened = true; // Set a flag to indicate the box is opened, if necessary
    // });
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

  Future<void> deleteIncome(int index,BuildContext context) async {
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
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      // setState(() {}); // Refresh the UI after deletion
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
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      // setState(() {}); // Refresh the UI after deletion
      update();
    }
  }

  Future<void> addIncome(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncome()),
    );
    _calculateTotalIncome(); // Recalculate the total income after adding a new entry
    //setState(() {}); // Refresh the state when coming back to HomeScreen
    update();
  }

  Future<void> addExpense(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddExpense()),
    );
    _calculateTotalExpense(); // Recalculate the total expense after adding a new entry
    //setState(() {}); // Refresh the state when coming back to HomeScreen
    update();
  }

}
