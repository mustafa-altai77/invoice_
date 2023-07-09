import 'package:shared_preferences/shared_preferences.dart';


class Prefer {
  static SharedPreferences? prefs;
  static int themeIndexPref = 0;
  static int localeIndexPref = 0;
   static Future init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }
}
