import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/expense_model.dart';
import 'package:expence_manager/Models/expense_model_adapter.dart';
import 'package:expence_manager/Views/Home_screen.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

// Custom input field function with optional icon and right-side icon option
Widget inputfield(TextEditingController controller, String hint, IconData? icon,
    bool obscure, TextInputType type,
    {bool isIconOnRight = false, VoidCallback? onTap}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: isIconOnRight ? null : (icon != null ? Icon(icon) : null),
        suffixIcon: isIconOnRight ? (icon != null ? Icon(icon) : null) : null,
        hintText: hint,
        hintStyle: TextStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      readOnly: onTap != null, // make readOnly if onTap is provided
      onTap: onTap,
    ),
  );
}

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  // Controllers for the text fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  late Box<ExpenseModel> _expenseBox;
  bool _isBoxOpened = false;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(ExpenseModelAdapter());
    }
    _expenseBox = await Hive.openBox<ExpenseModel>('expenses');
    setState(() {
      _isBoxOpened = true; // Set the flag to true when the box is opened
    });
  }

  // Method to handle button press
  void _handleAddExpense() async {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _dateController.text.isNotEmpty &&
        _isBoxOpened) {

      final expense = ExpenseModel(
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        description: _descriptionController.text,
        category: _categoryController.text,
        date: DateTime.parse(_dateController.text),
      );

      await _expenseBox.add(expense);

      print('Expense data added to Hive database');
      displayExpenseData();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields and ensure the box is opened')),
      );
    }
  }

  void displayExpenseData() async {
    List<ExpenseModel> fetchedExpenseData = _expenseBox.values.toList();
    print('Expense data fetched from Hive database: $fetchedExpenseData');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Add Expense',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimelineCalender(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Expense Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _titleController,
                'Enter Expense Title',
                null,
                false,
                TextInputType.text,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _amountController,
                'Enter Amount',
                Icons.attach_money,
                false,
                TextInputType.number,
                isIconOnRight: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Expense Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _categoryController,
                'Enter Expense Category',
                Icons.category,
                false,
                TextInputType.text,
                isIconOnRight: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _dateController,
                'Select Date',
                Icons.date_range,
                false,
                TextInputType.datetime,
                isIconOnRight: true,
                onTap: () => _selectDate(context), // show date picker on tap
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _descriptionController,
                'Enter Description',
                Icons.description,
                false,
                TextInputType.text,
                isIconOnRight: true,
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: CustomElevatedButton(
                    isdark: dark,
                    onPressed: _handleAddExpense,
                    label: 'Add Expense',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}