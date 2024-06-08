import 'package:flutter/material.dart';

Widget inputfield(
  TextEditingController controller,
  String hint,
  IconData Iconn,
  bool obsecure,
  TextInputType type,
) {
  return Container(
    margin: const EdgeInsets.only(
      left: 50,
      right: 50,
    ),
    child: TextField(
      controller: controller,
      keyboardType: type,
      obscureText: obsecure,
      decoration: InputDecoration(
        prefixIcon: Icon(Iconn),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
