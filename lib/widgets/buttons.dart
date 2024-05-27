import 'package:flutter/material.dart';

Widget savebutton(
  VoidCallback onpress,
  String savetxt,
) {
  return GestureDetector(
    onTap: onpress,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.blue,
      ),
      child: Center(
        child: Text('$savetxt'),
      ),
    ),
  );
}
