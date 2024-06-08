import 'package:get/get.dart';

class Button1Controller extends GetxController {
  var selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}
