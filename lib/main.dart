import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Components/theme/theme.dart';
import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/Reminder.dart';
import 'package:expence_manager/Views/add_page.dart';
import 'package:expence_manager/Views/auth/login.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/set_remainder.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom]);
  runApp(MainApp());
}
// await Hive.initFlutter();
//   runApp(ChangeNotifierProvider(
//       create: (context) => ThemeProvider(), child: MainApp()));
// }

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          // Reminder()
          Login(),
      theme: lightTheme,
      darkTheme: darkTheme,
      // theme: Provider.of<ThemeProvider>(context).themedata,
      // DefaultTabController(length: 3, child: CardNavigation())
    );
  }
}
