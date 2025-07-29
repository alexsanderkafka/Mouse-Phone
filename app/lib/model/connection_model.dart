class ConnectionModel {
  String _ip;
  String _hostname;

  ConnectionModel({required ip, required hostname})
    : _ip = ip,
      _hostname = hostname;

  String get ip => _ip;
  String get hostname => _hostname;
  set ip(String value) => _ip = value;
  set hostname(String value) => _hostname = value;
}
