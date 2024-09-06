import 'package:shared_preferences/shared_preferences.dart';


class Constants {
  static SharedPreferences? pref;

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
}
