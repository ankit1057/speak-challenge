import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> saveJson(String key, Map<String, dynamic> json) async {
    await _prefs.setString(key, jsonEncode(json));
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Map<String, dynamic>? getJson(String key) {
    final data = _prefs.getString(key);
    if (data != null) {
      return jsonDecode(data) as Map<String, dynamic>;
    }
    return null;
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
} 