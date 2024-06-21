import 'package:flutter/material.dart';
import 'package:get/get.dart';

class cardbtn extends Card {
  cardbtn({
    required this.onTap,
    required this.clicked,
    required this.text,
    required this.amount,
    required this.iconData,
  });
  @override
  final IconData iconData;
  final VoidCallback onTap;
  final int amount;
  final bool clicked;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Card(
      //color: clicked ? Colors.blue : Colors.white,
      elevation: 10,
      child: InkWell(
          onTap: onTap,
          child: Container(
              height: Get.height * 0.17,
              width: Get.width * 0.31,
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      iconData,
                      size: 40,
                      //color: clicked ? Colors.white : Colors.black
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      text,
                      style: TextStyle(
                          // color: clicked ? Colors.white : Colors.black,
                          fontSize: 13),
                    ),
                    Spacer(),
                    Text(
                      '\$' + ' $amount',
                      style: TextStyle(
                          //  color: clicked ? Colors.white : Colors.black,
                          fontSize: 20),
                    ),
                  ],
                ),
              ))),
    );
  }
}
