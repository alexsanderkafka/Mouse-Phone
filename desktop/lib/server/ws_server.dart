import 'dart:convert';
import 'dart:io';

import 'package:desktop/app/services/mouse_control.dart';
import 'package:desktop/dto/mouse_dto.dart';

class WebSocketServer {
  final int _port;
  HttpServer? _server;

  late MouseDto _mouseDto;

  WebSocketServer({required int port}) : _port = port;

  Future<void> init() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, _port);

    print("Server listening on ws://${_server!.address.address}:$_port");

    await for (var request in _server!) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        await _getRequest(request);
      } else {
        request.response.statusCode = HttpStatus.notFound;

        await request.response.close();
      }
    }
  }

  Future<void> _getRequest(HttpRequest request) async {
    WebSocket socket = await WebSocketTransformer.upgrade(request);

    print(
      "Connected on SocketServer => ${request.connectionInfo?.remoteAddress.toString()}",
    );

    socket.listen(
      (data) {
        print("Data received: $data");

        var jsonData = jsonDecode(data);

        _mouseDto = MouseDto.fromJson(jsonData);

        MouseControl control = MouseControl(mouse: _mouseDto);

        control.moveMouse();

        if (_mouseDto.left) {
          control.leftClick();
        }

        if (_mouseDto.right) {
          control.rightClick();
        }

        if (_mouseDto.scrollUp) {
          control.scrollUp();
        }

        if (_mouseDto.scrollDown) {
          control.scrollDown();
        }
      },
      onError: (error) {
        print("Error on SocketServer: $error");
      },
      onDone: () {
        print("Disconnected on SocketServer");
      },
    );
  }
}
