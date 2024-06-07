import 'package:expence_manager/Views/mainscreen.dart';
import 'package:expence_manager/widgets/Topbar.dart';
import 'package:expence_manager/widgets/input%20field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/buttons.dart';

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
                  genButton(
                    onTap: () {
                      Get.to(Mainscreen());
                    },
                    text: 'Signup',
                    width: Get.width * 0.7,
                    bloc: null, //complete animation on button here.
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
