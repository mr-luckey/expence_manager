import 'package:expence_manager/Components/theme/theme.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/auth/signup.dart';
import 'package:expence_manager/widgets/app_bar.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';

import '../../Components/helpers/theme_provider.dart';
import '../../widgets/Topbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  // final dark = isDarkMode(context);

  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      // backgroundColor:
      // backgroundColor: ThemeData.scaffoldBackgroundColor,
      // backgroundColor: T
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: Get.height / 20,
            // ),
            CustomAppBar(
              title: 'Login',
              onBackPressed: () {},
              isDark: dark,
              // isDark: dark,
            ),
            // topbar(
            //   title: 'Login',
            //   leading: IconButton(
            //     icon: Icon(
            //       Icons.arrow_back,
            //     ),
            //     onPressed: () {
            //       Get.back();
            //     },
            //   ),
            //   trailing: IconButton(
            //     icon: Icon(Icons.dark_mode_rounded),
            //     onPressed: () {
            //       Provider.of<ThemeProvider>(context, listen: false)
            //           .toggleTheme();
            //     },
            //   ),
            // ),
            Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height / 6,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(height: 50),
                  inputfield(_emailcontroller, 'Email', Icons.email, false,
                      TextInputType.emailAddress),
                  SizedBox(height: 30),
                  inputfield(_passwordcontroller, 'Password', Icons.password,
                      true, TextInputType.text),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  CustomElevatedButton(
                    label: 'Login',
                    isdark: dark,
                    onPressed: () {
                      Get.to(Mainscreen(
                          // selectedIndex: 1,
                          ));
                    },
                    //complete animation on button here.
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  CustomElevatedButton(
                    label: "Don't have an account?",
                    onPressed: () {
                      Get.to(Signup());
                    },
                    isdark: dark,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// 'Login', Get.to(const Mainscreen(
//                         // selectedIndex: 1,
//                         ));
// ,