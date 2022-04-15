import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static final String _kImportedKey = "imported_key";
  static final String _kOnBoardScreen = "on_board_screen";
  static final String _isUserLoggedIn = "is_user_loggedin";
  static final String _user = "user";

  static Future<Map<String, dynamic>> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString(_user);
    if (user != null) {
      return jsonDecode(user) as Map<String, dynamic>;
    }
    return null;
  }

  static Future setUser(user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_user, jsonEncode(user));
  }

  static Future removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_user);
  }

  static Future<bool> isUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isUserLoggedIn) ?? false;
  }

  static Future<bool> setIsUserLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_isUserLoggedIn, value);
  }

  /// GET Imported Key has been pressed or not
  static Future<bool> isMessageImported() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kImportedKey) ?? false;
  }

  /// SET Imported Key
  static Future<bool> setAlreadyImported(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kImportedKey, value);
  }

  /// GET Imported Key has been pressed or not
  static Future<bool> isOnBoardedGone() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kOnBoardScreen) ?? false;
  }

  /// SET Imported Key
  static Future<bool> setOnBoardedGone(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kOnBoardScreen, value);
  }
}
