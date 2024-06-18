import 'package:flutter/material.dart';

Widget circularbtn(String text) {
  return Container(
    height: 150,
    width: 150,
    decoration: BoxDecoration(
      //color: Colors.blue[100],
      borderRadius: BorderRadius.circular(100),
    ),
    child: Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        //color: Colors.blue,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            //color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}
