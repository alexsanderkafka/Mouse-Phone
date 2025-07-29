import 'package:mouse_phone/data/local_storage.dart';

class ConnectionService {
  final LocalStorage storage = LocalStorage();

  Future<String> getInfoInStorage(String key) async {
    return await storage.getString(key);
  }

  void saveInStorage(String key, String value) {
    storage.save(key, value);
  }
}
