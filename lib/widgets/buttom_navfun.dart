import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavigationService {
  NavigationService._privateConstructor();

  static final NavigationService _instance =
      NavigationService._privateConstructor();

  static NavigationService get instance => _instance;

  Future<void> changeScreen(BuildContext context, Widget screen,
      {bool withNavBar = true}) async {
    debugPrint('pushing screen $screen');
    await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(arguments: screen),
      screen: screen,
      withNavBar: withNavBar,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
    Get.to(() => screen);
  }
}
