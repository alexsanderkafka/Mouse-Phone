import 'package:mouse_phone/service/web_socket_service.dart';

class WebSocketModelView {
  final WebSocketService _ws;

  WebSocketModelView({required WebSocketService ws}) : _ws = ws;

  void sendData(Map<String, dynamic> data) {
    _ws.sendMouseData(data);
  }

  Future<void> initConnectionWithWebSocketService() async {
    await _ws.initChannel();
  }

  void disconnectWebSocketService() {
    _ws.disconnect();
  }
}
