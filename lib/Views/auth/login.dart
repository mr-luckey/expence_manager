import 'package:any_animated_button/any_animated_button.dart';
import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/Views/auth/signup.dart';
import 'package:expence_manager/widgets/buttons.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';

import '../../widgets/Topbar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            topbar(
              title: 'SignUp',
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
              ),
            ),
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
                  genButton(
                    onTap: () {
                      Get.to(const Mainscreen(
                          // selectedIndex: 1,
                          )); //TODO: need to uddate
                    },
                    text: 'Login',
                    width: Get.width * 0.7,
                    bloc: null,
                  ),
                  SizedBox(
                    height: Get.height / 20,
                  ),
                  genButton(
                      onTap: () {
                        Get.to(Signup());
                      },
                      text: "Don't have an account?",
                      width: Get.width * 0.7,
                      bloc: null)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
