import 'package:flutter/material.dart';
class LoaderProvider with ChangeNotifier {
  bool isLoading = false;
  bool get loader => isLoading;
  
 setloader(bool value) {
    isLoading = value;
    notifyListeners() ;
  print("object===================$value");
  }
}