
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
 
  static final ApiProvider _apiProvider = ApiProvider._internal();

  factory ApiProvider() {
    return _apiProvider;
  }

  ApiProvider._internal();

  
void showToastMsg(String msg) {
    Fluttertoast.showToast(
        msg: '$msg',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.black,
        fontSize: 14);
  }



}