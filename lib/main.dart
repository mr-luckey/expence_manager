import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:expence_manager/Components/googleSignIn.dart';
import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Components/theme/theme.dart';
import 'package:expence_manager/Models/goal_model.dart';
import 'package:expence_manager/Models/goal_model_adapter.dart';
import 'package:expence_manager/Models/income_model.dart';
import 'package:expence_manager/Models/income_model_adapter.dart';
import 'package:expence_manager/Views/Add_Goals.dart';
import 'package:expence_manager/Views/Reminder.dart';
// import 'package:expence_manager/Views/add_page.dart';
import 'package:expence_manager/Views/auth/login.dart';
import 'package:expence_manager/Views/home_screen.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/set_remainder.dart';
import 'package:expence_manager/widgets/Card_navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
      overlays: [SystemUiOverlay.bottom]);

  await Hive.initFlutter();
  Hive.registerAdapter(IncomeModelAdapter());
  await Hive.openBox<IncomeModel>('incomes');

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
      // home: FlutterSplashScreen.gif(
      //   backgroundColor: Colors.white10,
      //   gifPath: 'assets/example.gif',
      //   gifWidth: 269,
      //   gifHeight: 474,
      //   nextScreen: Googlesignin(),
      //   //  Mainscreen(
      //   //   initialIndex: 0,
      //   // ),
      //   duration: const Duration(milliseconds: 3515),
      //   onInit: () async {
      //     debugPrint("onInit");
      //   },
      //   onEnd: () async {
      //     debugPrint("onEnd 1");
      //   },
      // ),
      home: Mainscreen(
        initialIndex: 0,
      ),
      // Reminder()
      // Login(),
      theme: lightTheme,
      darkTheme: darkTheme,
      // theme: Provider.of<ThemeProvider>(context).themedata,
      // DefaultTabController(length: 3, child: CardNavigation())
    );
  }
}
