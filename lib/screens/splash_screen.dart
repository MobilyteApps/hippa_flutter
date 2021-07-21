import 'dart:async';
import 'package:app/common/get_it.dart';
import 'package:app/common/navigator_route.dart';
import 'package:app/common/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double? height;
  double? width;

  String login = '';

  void getotp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getString('islogged') ?? '';
    });
    startTime();
  }

  navigationPage() async {
    if (login == 'true') {
      locator<NavigationService>().navigateToReplace(grouplisting);
    } else {
      locator<NavigationService>().navigateToReplace(selection);
    }
  }

  startTime() async {
    final _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
    login = '';
    Future.delayed(Duration(seconds: 2), () {
      getotp();
    });
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/secure_text.png',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill),
          Center(
              child: Image.asset(
            'assets/images/logo_white.png',
          )),
        ],
      ),
    );
  }
}
