import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  void save(key, value) {
    _sharedPreferences.then((pref) => {pref.setString(key, value)});
  }

  Future<String> getString(key) async {
    String? currentValue = await _sharedPreferences.then(
      (pref) => pref.getString(key),
    );

    if (currentValue == null) {
      throw Exception("Value not found");
    }

    return currentValue;
  }
}
