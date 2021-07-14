import 'package:flutter/material.dart';

class Loader with ChangeNotifier {
  bool isLoading = false;
  bool get loader => isLoading;

  setloader(bool value) {
    isLoading = value;
    // if (value == true) {
    //   CircularProgressIndicator();
    // }
    // if (value == false) {
    //   Container();
    // }
    notifyListeners();
    print("object+++++++ $isLoading");
  }
}
