import 'package:flutter/material.dart';

Future changeScreen(BuildContext context, Widget screen,
    {bool withNavBar = true}) async {
  debugPrint('pushing screen $screen');
  // await PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
  //   context,
  //   settings: RouteSettings(name: '/$screen'),
  //   screen: screen,
  //   withNavBar: true,
  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
  // );
  // Get.to(screen);
}
