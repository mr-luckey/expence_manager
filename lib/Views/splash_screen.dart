import 'package:expence_manager/Controllers/Expense_controller.dart';
import 'package:expence_manager/Views/Login_with_google.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/Income_controller.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final incomeController = Get.put(IncomeController());
  final expenseController = Get.put(ExpenseController());
  @override
  void initState() {
    super.initState();
    incomeController.openHiveBox();
    expenseController.openHiveBox();
    incomeController.fetchIncomeData();
    _navigateToSignInScreen();
  }

  _navigateToSignInScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Mainscreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF199A8E),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/expense_manager.png",
                color: Colors.white, // Change logo color to white
                colorBlendMode: BlendMode.modulate, // Apply the color filter
                height: 250, // Adjust the size as needed
              ),


            ],
          ),
        ),
      ),
    );
  }
}
