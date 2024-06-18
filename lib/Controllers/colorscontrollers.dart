import 'package:get/get.dart';
import 'package:flutter/material.dart';

// class ColorController extends GetxController {
//   var containerColors = <Color>[Colors.red, Colors.green, Colors.blue].obs;

//   void changeColor(int index, Color color) {
//     containerColors[index] = color;
//   }
// }
// import 'package:get/get.dart';

class ButtonController extends GetxController {
  var selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}
