import 'package:flutter/material.dart';

class containersav extends StatelessWidget {
  const containersav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10), // Adjust the value as needed
      ),
    );
  }
}
