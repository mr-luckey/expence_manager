import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/add_income.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/todo_screen.dart';
import 'package:expence_manager/Views/total_Expense.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, BuildContext? initialIndex});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<IncomeModel>? _incomeBox;
  bool _isBoxOpened = false;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _openHiveBox();
  }

  @override
  void dispose() {
    Hive.close(); // Close all Hive boxes when the app is terminated
    super.dispose();
  }

  Future<void> _openHiveBox() async {
    await Hive.initFlutter(); // Initialize Hive for Flutter
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(IncomeModelAdapter()); // Register the adapter
    }

    final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path); // Initialize Hive with the app's document directory

    _incomeBox = await Hive.openBox<IncomeModel>('incomes');

    // Testing the Hive box by printing the first value
    if (_incomeBox!.isNotEmpty) {
      print("TESTING HIVE");
      print(_incomeBox!.values.first);
    }

    _calculateTotalAmount(); // Calculate the initial total amount

    setState(() {
      _isBoxOpened = true; // Set a flag to indicate the box is opened, if necessary
    });
  }

  void _calculateTotalAmount() {
    totalAmount = 0;
    if (_incomeBox != null) {
      for (var income in _incomeBox!.values) {
        totalAmount += double.parse(income.amount);
      }
    }
    print('Total amount: \$${totalAmount.toStringAsFixed(2)}');
  }

  Future<void> _deleteIncome(int index) async {
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
                // Future.delayed(Duration(seconds: 05));
                print("TESTING BACK");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Mainscreen(initialIndex: 0),
                  ),
                );
                _calculateTotalAmount();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      final income = _incomeBox?.getAt(index);
      _incomeBox?.deleteAt(index);
      // totalAmount -= double.parse(income!.amount);
      // setState(() {}); // Refresh the state after deletion
    }
  }

  Future<void> _addIncome() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddIncome()),
    );
    _calculateTotalAmount(); // Recalculate the total amount after adding a new entry
    setState(() {}); // Refresh the state when coming back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addIncome,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: 'Overview',
              isDark: dark,
              onBackPressed: () {
                Get.back();
              },
            ),
            SizedBox(
              height: Get.height / 300,
            ),
            CardNavigation(totalIncome: totalAmount,),
            SizedBox(
              height: Get.height / 50,
            ),
            Container(
              height: Get.height * 0.06,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Btn(
                      isdark: dark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SavingPage()),
                        );
                      },
                      text: 'Saving',
                      iconData: Icons.add,
                      index: 0,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReminderPage()),
                        );
                      },
                      text: 'Remind',
                      iconData: Icons.notifications_active_outlined,
                      index: 1,
                    ),
                    Btn(
                      isdark: dark,
                      onTap: () {},
                      text: 'Budget',
                      iconData: Icons.savings_outlined,
                      index: 2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 60,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Entries",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: dark ? Colors.white : Colors.blue.shade900),
                  ),
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: dark ? Colors.white : Colors.blue.shade900),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TotalExpense()));
                      },
                      child: Center(
                          child: Icon(Icons.more_vert_rounded,
                              color: dark ? Colors.white : Colors.blue.shade900)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 400,
                width: double.infinity,
                child: _incomeBox != null
                    ? _incomeBox!.isOpen
                    ? ValueListenableBuilder(
                  valueListenable: _incomeBox!.listenable(),
                  builder: (context, Box<IncomeModel> box, _) {
                    if (box.values.isEmpty) {
                      return Center(
                        child: Text(
                          'No income entries',
                          style: TextStyle(
                            color: dark ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        final income = box.getAt(index);
                        return Card(
                          margin:
                          const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      income?.title ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      'Amount: ${income?.amount ?? ''}',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Description: ${income?.description ?? ''}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Category: ${income?.categoryIndex.toString() ?? ''}',
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
                                    onPressed: () =>
                                        _deleteIncome(index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                )
                    : Center(
                  child: CircularProgressIndicator(),
                )
                    : CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
