import 'package:expence_manager/Views/Login_with_google.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToSignInScreen();
  }

  _navigateToSignInScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignInScreen()));
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
                "assets/images/expense manager.png",
                color: Colors.white, // Change logo color to white
                colorBlendMode: BlendMode.modulate, // Apply the color filter
                height: 250, // Adjust the size as needed
              ),
              SizedBox(height: 20), // Space between the logo and the text
              Text(
                'PDF Reader',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Update text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
