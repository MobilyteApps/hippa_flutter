import 'package:flutter/cupertino.dart';

class AppSize {
  double height(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return size;
  }

  double width(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return size;
  }
}
