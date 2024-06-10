import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:any_animated_button/any_animated_button.dart';
import 'package:expence_manager/Controllers/colorscontrollers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Custom input field function with optional icon and right-side icon option
Widget inputfield(
    TextEditingController controller,
    String hint,
    IconData? icon,
    bool obscure,
    TextInputType type,
    {bool isIconOnRight = false}) { // Added a parameter for icon position
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5), // Reduced vertical margin
    child: TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold), // Set text color to grey
      decoration: InputDecoration(
        prefixIcon: isIconOnRight ? null : (icon != null ? Icon(icon, color: Colors.grey) : null), // Conditional icon on left
        suffixIcon: isIconOnRight ? (icon != null ? Icon(icon, color: Colors.grey) : null) : null, // Conditional icon on right
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey), // Set hint text color to grey
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15), // Reduced height
      ),
    ),
  );
}

class AddExpense extends StatefulWidget { // Changed class name to AddExpense
  const AddExpense({Key? key}) : super(key: key); // Changed class constructor name

  @override
  State<AddExpense> createState() => _AddExpenseState(); // Changed state creation method
}

class _AddExpenseState extends State<AddExpense> { // Changed class name to AddExpenseState
  // Controllers for the text fields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Selected index for the Card widgets
  int _selectedIndex = -1;

  // Method to handle button press
  void _handleAddExpense() { // Changed method name to _handleAddExpense
    // Handle the button press logic here
    print('Add Expense button pressed');
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
            color: _selectedIndex == index ? Colors.white : Colors.black,
          ),
        );
      case 1:
        return Center(
          child: Text(
            'Health',
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        );
      case 2:
        return Center(
          child: Text(
            'Grocery',
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        );
      default:
        return Center(
          child: Text(
            'Item $index',
            style: TextStyle(
              color: _selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Expense', // Changed app bar title
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
                  'Income Title', // Changed text
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              inputfield(
                _amountController,
                '',
                null, // Removed icon
                false,
                TextInputType.text, // English and number keyboard
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Amount',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              inputfield(
                _descriptionController,
                '',
                Icons.attach_money,
                false,
                TextInputType.number, // Number keyboard
                isIconOnRight: true, // Icon on right side
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  'Expense Category', // Changed text
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _onContainerTap(index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        height: 60,  // Reduced height
                        width: 60,   // Reduced width
                        decoration: BoxDecoration(
                          color: _selectedIndex == index ? Colors.blue : Colors.white,
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
                    onTap: _handleAddExpense, // Changed method name
                    text: 'Add Expense', // Changed button text
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
