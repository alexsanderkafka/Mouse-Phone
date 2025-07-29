import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final String? _ip;
  final int _port = 8888;

  late WebSocketChannel _socket;

  WebSocketService({required ip}) : _ip = ip;

  Future<void> initChannel() async {
    try {
      final uri = Uri.parse('ws://$_ip:$_port');
      _socket = WebSocketChannel.connect(uri);

      await _socket.ready;
    } catch (e) {
      print("Error channel: $e");
      disconnect();
      throw Exception("Error channel: $e");
    }
  }

  void sendMouseData(Map<String, dynamic> data) {
    final String jsonDataToString = jsonEncode(data);

    _socket.sink.add(jsonDataToString);
  }

  void disconnect() {
    _socket.sink.close();
  }

  Future<dynamic> listenWs() async {
    _socket.stream.listen((event) {
      print(event);
    });
  }
}
