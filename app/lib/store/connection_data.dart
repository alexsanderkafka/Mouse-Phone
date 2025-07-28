import 'package:mobx/mobx.dart';

part 'connection_data.g.dart';

class ConnectionData = ConnectionDataBase with _$ConnectionData;

abstract class ConnectionDataBase with Store {
  @observable
  String ip = '192.168.0.1';

  @observable
  String hostname = 'Nome-do-PC';

  @action
  void setIp(String value) {
    ip = value;
  }

  @action
  void setHostname(String value) {
    hostname = value;
  }
}
