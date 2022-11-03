import 'dart:io';

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
