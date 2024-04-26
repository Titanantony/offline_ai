import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Future<String> getvalue(key) async {
    SharedPreferences sharedpreferences = await SharedPreferences.getInstance();
    return sharedpreferences.getString(key) ?? '';
  }

  Future<void> setvalue(key, value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, value);
  }
}
