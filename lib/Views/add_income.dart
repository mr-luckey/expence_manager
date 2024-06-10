import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:expence_manager/widgets/timeline_calender.dart';
import 'package:flutter/material.dart';

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

class AddIncome extends StatefulWidget {
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  // Controllers for the text fields
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Income',
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
            ],
          ),
        ),
      ),
    );
  }
}
