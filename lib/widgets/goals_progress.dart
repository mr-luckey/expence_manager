import 'package:flutter/material.dart';

Widget progress(
  IconData iconData,
  String title,
) {
  return Row(
    children: [
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          backgroundBlendMode: BlendMode.clear,
          border: Border.all(
              //color: Colors.black45
              ),
        ),
        child: Center(
          child: Icon(
            iconData,
            //color: Colors.black54,
            size: 30,
          ),
        ),
      ),
      Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              //color: Colors.black87
            ),
          ),
        ],
      )
    ],
  );
}
