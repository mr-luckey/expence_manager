// ignore_for_file: unused_import

import 'package:expence_manager/Views/Latest_Entries.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:any_animated_button/any_animated_button.dart';
import 'package:expence_manager/Controllers/colorscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Custom input field function with optional icon and right-side icon option
Widget inputfield(TextEditingController controller, String hint, IconData? icon,
    bool obscure, TextInputType type,
    {bool isIconOnRight = false}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
    child: TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      style: TextStyle(
          // color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        prefixIcon: isIconOnRight
            ? null
            : (icon != null
                ? Icon(
                    icon,
                    //  color: Colors.grey
                  )
                : null),
        suffixIcon: isIconOnRight
            ? (icon != null
                ? Icon(
                    icon,
                    // color: Colors.grey
                  )
                : null)
            : null,
        hintText: hint,
        hintStyle: TextStyle(
            // color:
            // Colors.grey
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
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
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Selected index for the Card widgets
  int _selectedIndex = -1;

  // Method to handle button press
  void _handleAddExpense() {
    // Handle the button press logic here, e.g., saving the expense

    // Navigate to the LatestEntries page
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => LatestEntries()),
    );
  }

  // Method to handle container tap
  void _onContainerTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to build container content
  Widget _buildContainerContent(int index) {
    switch (index) {
      case 0:
        return Center(
          child: Icon(
            Icons.add,
            // color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        );
      case 1:
        return Center(
          child: Text(
            'Health',
            style: TextStyle(
                // color: _selectedIndex == index ? Colors.white : Colors.black,
                ),
          ),
        );
      case 2:
        return Center(
          child: Text(
            'Grocery',
            style: TextStyle(
                // color: _selectedIndex == index ? Colors.white : Colors.black,
                ),
          ),
        );
      default:
        return Center(
          child: Text(
            'Item $index',
            style: TextStyle(
                // color: _selectedIndex == index ? Colors.white : Colors.black,
                ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
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
                  'Income Title',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    // color: Colors.grey
                  ),
                ),
              ),
              inputfield(
                _amountController,
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
                    // color: Colors.grey
                  ),
                ),
              ),
              inputfield(
                _descriptionController,
                '',
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
                    // color: Colors.grey
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _onContainerTap(index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          // color: _selectedIndex == index
                          //     ? Colors.blue
                          //     : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black45),
                        ),
                        child: _buildContainerContent(index),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: genButton(
                    onTap: _handleAddExpense,
                    text: 'Add Expense',
                    enabled: true,
                    width: double.infinity,
                    bloc: null,
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
