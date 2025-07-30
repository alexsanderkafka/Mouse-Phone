import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<void> save(key, value) async {
    final pref = await _sharedPreferences;
    await pref.setString(key, value);
  }

  Future<String> getString(key) async {
    final pref = await _sharedPreferences;

    String? currentValue = pref.getString(key);

    if (currentValue == null) {
      return "";
    }

    print("Buscou os dados: $currentValue");

    return currentValue;
  }
}
