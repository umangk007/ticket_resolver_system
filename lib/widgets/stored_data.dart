import 'package:shared_preferences/shared_preferences.dart';

class StoredData {

  static const tokenKey = "token";
  static const userKey = "user";
  static const isFirstTimeKey = "is_first";
  static const keyId = "id";


  static Future setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }
  static Future setUserData(String userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, userData);
  }

  // static Future setId(int id) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(keyId, id);
  // }

}
