import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final SharedPreferences _preferences;
  SharedPreferenceService({required SharedPreferences preferences})
    : _preferences = preferences;

  /// Set SharedPreference data method
  Future<void> setData<T>(String key, dynamic value) async {
    switch (T) {
      case String:
        await _preferences.setString(key, value);
        break;
      case int:
        await _preferences.setInt(key, value);
        break;
      case double:
        await _preferences.setDouble(key, value);
        break;
      case bool:
        await _preferences.setBool(key, value);
        break;
    }
  }

  /// Get SharedPreference data method
  T getData<T>(String key) {
    dynamic data;
    switch (T) {
      case String:
        data = _preferences.getString(key) ?? '';
        break;
      case int:
        data = _preferences.getInt(key) ?? -1;
        break;
      case double:
        data = _preferences.getDouble(key) ?? 0.0;
        break;
      case bool:
        data = _preferences.getBool(key) ?? false;
        break;
    }
    return data as T;
  }

  void clearAll() => _preferences.clear();
}
