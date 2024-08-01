import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Models/income_model.dart';
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

// Input field widget
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
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
      readOnly: onTap != null, // make readOnly if onTap is provided
      onTap: onTap,
    ),
  );
}

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Box<ExpenseModel> _expenseBox;
  bool _isBoxOpened = false;
  bool _isIncomeSelected = true;

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

  void _handleAddTransaction() async {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _categoryController.text.isNotEmpty &&
        _datetimeController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {

      if (_isIncomeSelected) {
        final income = IncomeModel(
          title: _titleController.text,
          amount: _amountController.text,
          category: int.parse(_categoryController.text),
          dateTime: DateTime.parse(_datetimeController.text),
          description: _descriptionController.text,
          type: 'income',
        );

        final box = await Hive.openBox<IncomeModel>('incomes');
        await box.add(income);
        print('Income data added to Hive database');
      } else {
        final expense = ExpenseModel(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          description: _descriptionController.text,
          category: _categoryController.text,
          dateTime: DateTime.parse(_datetimeController.text),
          type: 'expense',
        );

        await _expenseBox.add(expense);
        print('Expense data added to Hive database');
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null)
      setState(() {
        _datetimeController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        isDark: dark,
        title: 'Add Transaction',
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
              Center(
                child: ToggleButtons(
                  isSelected: [_isIncomeSelected, !_isIncomeSelected],
                  onPressed: (int index) {
                    setState(() {
                      _isIncomeSelected = index == 0;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text('Income'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text('Expense'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  _isIncomeSelected ? 'Income Title' : 'Expense Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _titleController,
                '',
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
                '',
                Icons.attach_money,
                false,
                TextInputType.number,
                isIconOnRight: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  _isIncomeSelected ? 'Income Category' : 'Expense Category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _categoryController,
                '',
                Icons.category,
                false,
                TextInputType.number,
                isIconOnRight: true,
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Datetime',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              inputfield(
                _datetimeController,
                '',
                Icons.date_range,
                false,
                TextInputType.datetime,
                isIconOnRight: true,
                onTap: () => _selectDate(context),
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
                '',
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
                    onPressed: _handleAddTransaction,
                    label: _isIncomeSelected ? 'Add Income' : 'Add Expense', title: null,
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
