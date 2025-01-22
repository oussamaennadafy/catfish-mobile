import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  static Future<bool> getIsFirstTimeOpen() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final storedValue = sharedPreferences.getBool("firstTimeOpen");

    return storedValue ?? false;
  }

  static Future<bool> setIsFirstTimeOpen(bool firstTimeOpen) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    final storedValue = sharedPreferences.setBool("firstTimeOpen", firstTimeOpen);

    return storedValue;
  }
}
