import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static SharedPreferences? sharedPref;


  static const _initialLogin  = "initialLogin";


  static Future<SharedPreferences> getPref() async {
    return sharedPref ??= await SharedPreferences.getInstance();
    // SharedPreferences.setMockInitialValues({});
  }

  Future<void> clearPreference() async {
    var pref = await getPref();
    pref.clear();
  }

  static void saveInitialLogin()async {
    var pref = await getPref();
    pref.setBool(_initialLogin, true);
    print("initial login saved");
  }


  static Future<bool> getInitialLogin() async {
    var pref = await getPref();
    var status = await pref.getBool(_initialLogin);
    if(status != null) {
      return status;
    } else {
      return false;
    }
  }




}
