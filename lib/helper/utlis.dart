import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
  static String androidId =
      "196317924504-skba256ujegts4n52gi9hmcag5bji3l2.apps.googleusercontent.com";
  static String iosId =
      "196317924504-erdup4ga4dun3t7uqb7l8cnrjst675lb.apps.googleusercontent.com";
  static String id = "";
}

const platform = MethodChannel('samples.flutter.dev/battery');

Future<dynamic> saveToDocuments(String filePath) async {
  return await platform.invokeMethod('saveToDocuments', filePath);
}
String formatedDate(String format, String timeStamp) {
  if (timeStamp == null || timeStamp.isEmpty) return "";
  final f = DateFormat(format);
  DateTime dateTime = DateTime.parse(timeStamp);
  if (dateTime != null) {
    return f.format(dateTime);
  }
  return "";
}
String imageURL="";