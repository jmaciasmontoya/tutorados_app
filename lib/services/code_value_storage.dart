import 'package:shared_preferences/shared_preferences.dart';

class CodeValueStorage {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<T?> getValue<T>(String code) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        return prefs.getInt(code) as T?;
      case String:
        return prefs.getString(code) as T?;

      default:
        throw UnimplementedError(
            'GET No implementado para tipo ${T.runtimeType}');
    }
  }

  Future<bool> removeCode(String code) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(code);
  }

  Future<void> setValueCode<T>(String code, T value) async {
    final prefs = await getSharedPrefs();

    switch (T) {
      case int:
        prefs.setInt(code, value as int);
        break;
      case String:
        prefs.setString(code, value as String);
        break;

      default:
        throw UnimplementedError(
            'SET No implementado para tipo ${T.runtimeType}');
    }
  }
}
