import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        // color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'Circular Container',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            //color: Colors.white
          ),
        ),
      ),
    );
  }
}
