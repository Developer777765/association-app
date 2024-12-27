// ignore_for_file: constant_identifier_names
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  
  static const String USER_ID = "USER_ID";
  static const String USER_NAME = "USER_ID";
  static final Preference _preference = Preference._internal();
  factory Preference() {
    return _preference;
  }

  Preference._internal();
  static Preference get shared => _preference;
  static SharedPreferences? _prefValues;

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefValues = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    if (_prefValues == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _prefValues!.getString(key);
  }

  Future<bool> setString(String key, String value) {
    if (_prefValues == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _prefValues!.setString(key, value);
  }
}
