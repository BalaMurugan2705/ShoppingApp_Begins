import 'dart:collection';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/appUser.dart';


class SecureStorage {
  // Create storage
  static final storage = FlutterSecureStorage();

  static const _userData = "userData";



  static saveUserData(AppUser userData) {
    String user = jsonEncode(userData.toJson());
    storage.write(key: _userData, value: user);
  }

  static Future<AppUser> getUserData() async {
    var data2 = await storage.read(key: _userData);
    var data = await jsonDecode(data2.toString());

    return AppUser().fromMap(
      data as LinkedHashMap,
    );
  }






  static deleteAll() async {
    // Delete all
    await storage.deleteAll();
  }





//Read Functions

// static Future<String> getPassword() {}

// Example

// Read value
//String value = await storage.read(key: key);

// Read all values
//<String, String> allValues = await storage.readAll();

// Delete value
// await storage.delete(key: key);

// Write value
//await storage.write(key: key, value: value);
}
