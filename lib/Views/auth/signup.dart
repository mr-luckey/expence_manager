import 'package:expence_manager/Components/helpers/theme_provider.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/buttons.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmPasswordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final dark = ThemeProvider().isDarkMode(context);
    return Scaffold(
      body: Column(
        children: [
          // topbar(
          //   title: 'SignUp',
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back),
          //     onPressed: () {
          //       Get.back();
          //     },
          //   ),
          //   trailing: IconButton(
          //     icon: Icon(Icons.menu),
          //     onPressed: () {},
          //   ),
          // ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 6,
                ),
                CircleAvatar(
                  radius: 50,
                  child: const Icon(Icons.person),
                ),
                const SizedBox(height: 50),
                inputfield(_emailcontroller, 'Email', Icons.email, false,
                    TextInputType.emailAddress),
                const SizedBox(height: 30),
                inputfield(_passwordcontroller, 'Password', Icons.password,
                    true, TextInputType.text),
                const SizedBox(height: 30),
                inputfield(_confirmPasswordcontroller, 'Confirm Password',
                    Icons.password, true, TextInputType.text),
                SizedBox(
                  height: Get.height / 20,
                ),
                CustomElevatedButton(
                  label: 'Signup',
                  isdark: dark,
                  onPressed: () {
                    Get.to(Mainscreen(
                        // selectedIndex: 1,
                        ));
                  }, title: null,

                  //complete animation on button here.
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 'Signup',