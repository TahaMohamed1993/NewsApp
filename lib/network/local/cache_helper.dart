import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper {
  static SharedPreferences? sharedPreferences;
  static inti() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static bool? getData({required bool value}) {
    return sharedPreferences!.getBool(value as String);
  }
}
