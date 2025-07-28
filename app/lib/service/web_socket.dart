import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:io';

import 'package:web_socket_channel/web_socket_channel.dart';

/*
class WebSocket {
  final String? _ip;
  final int _port = 8888;

  late IO.Socket _socket;

  WebSocket({required ip}) : _ip = ip;

  Future<void> initChannel() async {
    try {
      _socket = IO.io(
        "http://$_ip:$_port",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .build(),
      );

      _socket.onConnect((_) {
        print("Connected");
      });
    } catch (e) {
      print("Error channel: $e");
    }
  }

  void sendMouseMovementData(var data) {
    _socket.emit("mouseAction", data);
  }

  void disconnect() {
    _socket.disconnect();
  }
}*/

class WebSocket {
  final String? _ip;
  final int _port = 8888;

  late WebSocketChannel _socket;

  WebSocket({required ip}) : _ip = ip;

  Future<void> initChannel() async {
    try {
      final uri = Uri.parse('ws://$_ip:$_port');
      _socket = WebSocketChannel.connect(uri);

      await _socket.ready;
    } catch (e) {
      print("Error channel: $e");
    }
  }

  void sendMouseData(Map<String, dynamic> data) {
    final String jsonDataToString = jsonEncode(data);

    _socket.sink.add(jsonDataToString);
  }

  void disconnect() {
    _socket.sink.close();
  }
}
