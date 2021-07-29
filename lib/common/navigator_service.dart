import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  Future<dynamic> navigateToReplace(String routeName) {
    return navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }

  Future<dynamic> argsnavigateToReplace(String routeName, String id) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: id);
  }

  backPress() {
    navigatorKey.currentState!.pop();
  }
}
