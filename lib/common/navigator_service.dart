import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  // Future<dynamic> navigateArgTo(String routeName, dynamic value) {
  //   return navigatorKey.currentState.pushNamed(routeName, arguments: value);
  // }

  // Future<dynamic> navigateToReplaceArg(String routeName, dynamic value) {
  //   return navigatorKey.currentState.pushNamedAndRemoveUntil(
  //       routeName, (Route<dynamic> route) => false,
  //       arguments: value);
  // }

  Future<dynamic> navigateToReplace(String routeName) {
    return navigatorKey.currentState
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }
   




  backPress() {
    navigatorKey.currentState.pop();
  }
}
