import 'package:flutter/material.dart';
class Loader with ChangeNotifier {
  bool isLoading = false;
  bool get loader => isLoading;
  
 setloader(bool value) {
    isLoading = value;
     notifyListeners(); 
     print("object+++++++ $isLoading"); 
  }
}