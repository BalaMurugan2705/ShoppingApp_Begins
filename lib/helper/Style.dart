import 'package:flutter/material.dart';

class FdStyle {
  static TextStyle sofia(
      {double fontSize = 16,
      fontFamily = 'Sofia pro',
      color = Colors.black,
      double letterSpace = 0.0,
      fontWeight = FontWeight.w400,
      fontStyle = FontStyle.normal}) {
    return TextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpace,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle sofiaTitle(
      {double fontSize = 34,
      fontFamily = 'Sofia pro bold',
      color = Colors.black,
      double letterSpace = 0.0,
      fontWeight = FontWeight.w400,
      fontStyle = FontStyle.normal}) {
    return TextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpace,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle sofiaBold(
      {double fontSize = 17,
      fontFamily = 'Sofia pro bold',
      color = Colors.black,
      double letterSpace = 0.0,
      fontWeight = FontWeight.w400,
      fontStyle = FontStyle.normal}) {
    return TextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpace,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle metropolisBold(
      {double fontSize = 17,
      fontFamily = 'Metropolis Black',
      color = Colors.black,
      double letterSpace = 0.0,
      fontWeight = FontWeight.w400,
      fontStyle = FontStyle.normal}) {
    return TextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpace,
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontStyle: fontStyle);
  }

  static TextStyle metropolisRegular({
    double fontSize = 17,
    fontFamily = 'Metropolis Regular',
    color = Colors.black,
    double letterSpace = 0.0,
    fontWeight = FontWeight.w400,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpace,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
    );
  }
}
