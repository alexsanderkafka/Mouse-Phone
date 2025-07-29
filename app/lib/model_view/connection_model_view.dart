import 'package:mobx/mobx.dart';
import 'package:mouse_phone/model/connection_model.dart';
import 'package:mouse_phone/service/connection_service.dart';

part 'connection_model_view.g.dart';

class ConnectionModelView = ConnectionModelViewBase with _$ConnectionModelView;

abstract class ConnectionModelViewBase with Store {
  final ConnectionService connectionService = ConnectionService();

  @observable
  ConnectionModel connectionModel = ConnectionModel(ip: "", hostname: "");

  @action
  void setIp(String value) {
    connectionModel.ip = value;
    connectionService.saveInStorage("ip", value);
  }

  @action
  void setHostname(String value) {
    connectionModel.hostname = value;
    connectionService.saveInStorage("hostname", value);
  }

  @action
  Future<void> setConnectionModel() async {
    String ip = await connectionService.getInfoInStorage("ip");
    String hostname = await connectionService.getInfoInStorage("hostname");

    connectionModel.ip = ip;
    connectionModel.hostname = hostname;
  }
}
