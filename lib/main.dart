import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/add_page.dart';
import 'package:expence_manager/Views/auth/login.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,

       home: AddGoals()
      // Mainscreen(
      //     // selectedIndex: 0,
      //     ),

      // DefaultTabController(length: 3, child: CardNavigation())
    );
  }
}
