import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Components/theme/theme.dart';
import 'package:expence_manager/Controllers/Income_controller.dart';
import 'package:expence_manager/Models/expense_model.dart';
import 'package:expence_manager/Models/expense_model_adapter.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/Models/goal_model_adapter.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/Login_with_google.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/auth/login.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/set_remainder.dart';
import 'package:expence_manager/Views/splash_screen.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: [SystemUiOverlay.bottom]);


  await Hive.initFlutter();

  // Register all adapters
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(GoalAdapter());

  // Open Hive boxes
  await Hive.openBox<ExpenseModel>('expenses');
  await Hive.openBox<IncomeModel>('incomes');
  await Hive.openBox<Goal>('goals');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      //Login(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
