import 'package:food_app_2/helper/secure_storage_helper.dart';

Future<String> getUserName() async {
  var userData = await SecureStorage.getUserData();
  return userData.name ?? "" + userData.lastname.toString() ?? "";
}

Future<String> getUserMail() async {
  var userData = await SecureStorage.getUserData();
  return userData.email ?? "";
}

Future<String> getUserImage() async {
  var userData = await SecureStorage.getUserData();
  return userData.image ?? "";
}

Future<String> getMobileNumber() async {
  var userData = await SecureStorage.getUserData();
  return userData.phone ?? "";
}

Future<String> getUiD() async {
  var userData = await SecureStorage.getUserData();
  print(userData.uid);
  return userData.uid ?? "";
}
