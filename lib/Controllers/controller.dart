import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class Button1Controller extends GetxController {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  // var index = 0.obs;

  // void updateIndex(index) {
  //   controller = PersistentTabController(initialIndex: index);
  //   update();
  // }

  var selectedIndex = 0.obs;

  void selectButton(int index) {
    selectedIndex.value = index;
  }
}
