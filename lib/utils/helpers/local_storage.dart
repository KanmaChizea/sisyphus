import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  SharedPreferences? _prefs;

  /// Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Method to save a value to local storage
  Future<void> saveData(String key, dynamic value) async {
    if (_prefs == null) await init();
    if (_prefs == null) throw Exception("LocalStorageService not initialized");
    if (value is String) {
      await _prefs!.setString(key, value);
    } else if (value is int) {
      await _prefs!.setInt(key, value);
    } else if (value is bool) {
      await _prefs!.setBool(key, value);
    } else if (value is double) {
      await _prefs!.setDouble(key, value);
    } else if (value is List<String>) {
      await _prefs!.setStringList(key, value);
    } else {
      throw Exception("Unsupported data type");
    }
  }

  /// Method to read a value from local storage
  dynamic getData(String key) {
    if (_prefs == null) throw Exception("LocalStorageService not initialized");
    return _prefs!.get(key);
  }

  /// Method to remove a value from local storage
  Future<void> removeData(String key) async {
    if (_prefs == null) await init();
    await _prefs!.remove(key);
  }
}
