import 'package:flutter/material.dart';

Text getBoldText(String text,
    {Color textColor = const Color.fromRGBO(52, 52, 52, 1.0),
    double fontSize = 16}) {
  return Text(text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w700,
        fontSize: fontSize,
      ));
}

Text getSemiBolText(String text,
    {Color textColor = const Color.fromRGBO(52, 52, 52, 1.0),
    double fontSize = 16}) {
  return Text(text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ));
}

Text getLightText(String text,
    {Color textColor = const Color.fromRGBO(52, 52, 52, 1.0),
    double fontSize = 16}) {
  return Text(text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w300,
        fontSize: fontSize,
      ));
}

Text getMediumText(String text,
    {Color textColor = const Color.fromRGBO(52, 52, 52, 1.0),
    double fontSize = 16}) {
  return Text(text,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize,
      ));
}

Text getRegularText(String text,
    {Color textColor = const Color.fromRGBO(52, 52, 52, 1.0),
    double fontSize = 16,
    dynamic alignment = TextAlign.center}) {
  return Text(text,
      textAlign: alignment,
      style: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ));
}