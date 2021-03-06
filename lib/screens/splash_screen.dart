
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
 double height;
 double width;
  navigationPage() async {
    //  final prefs = await SharedPreferences.getInstance();
    // final user = prefs.getString('user');

    // if(user != null && user.isNotEmpty){
    //     locator<NavigationService>().navigateToReplace(login);
    // }else{
    //       locator<NavigationService>().navigateToReplace(event);
    // }
   
     locator<NavigationService>().navigateToReplace(home) ;
  
  }

   startTime() async {
    final _duration = Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    super.initState();
   startTime();
  }


  @override
  Widget build(BuildContext context) {
   height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
    
      body: Container(
        
       height: height,
       width:width,
        child:Center(child:
        Icon(Icons.cloud,size: 150,color: Colors.black,)))
      
    );
  }
}
