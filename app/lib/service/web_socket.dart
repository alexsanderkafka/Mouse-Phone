import 'package:web_socket_channel/io.dart';

class WebSocket {
  final String? _ip;
  final int? _port;

  IOWebSocketChannel? _channel;

  WebSocket({required ip, required port}) : _ip = ip, _port = port;

  Future<void> initChannel() async {
    final channel = IOWebSocketChannel.connect('ws://$_ip:$_port');

    _channel = channel;
  }

  Future<void> sendDataToWs(var data) async {
    if (_channel == null) {
      throw Exception("Init channel first");
    }

    _channel!.sink.add(data);
  }
}
