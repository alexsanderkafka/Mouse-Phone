import 'dart:io';

class WebSocketServer {
  final int _port;
  HttpServer? _server;

  WebSocketServer({required int port}) : _port = port;

  Future<void> init() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, _port);

    print("Server listening on ws://${_server!.address.address}:$_port");

    await for (var request in _server!) {
      if (WebSocketTransformer.isUpgradeRequest(request)) {
        await _getRequest(request);
      }

      request.response.statusCode = HttpStatus.notFound;

      request.response.close();
    }
  }

  Future<void> _getRequest(HttpRequest request) async {
    WebSocket socket = await WebSocketTransformer.upgrade(request);

    print(
      "Connected on SocketServer => ${request.connectionInfo?.remoteAddress.toString()}",
    );

    socket.listen(
      (data) {
        //Entra a parte de alterar o cursos do mouse
        print("Data received: $data");
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
