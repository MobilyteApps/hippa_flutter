
import 'package:app/language/app_translation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 double height;
 double width;



void login() {

}

  @override
  Widget build(BuildContext context) {
   height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
    appBar: AppBar(title: Text(AppTranslations.of(context).text('tab_home')),),
      body: Container(
        
       height: height,
       width:width,
        child:Center(child:Text("home")
        
    ))
      
    );
  }
}
