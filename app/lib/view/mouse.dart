import 'package:flutter/material.dart';
import 'package:mouse_phone/model_view/web_socket_model_view.dart';
import 'package:mouse_phone/service/web_socket_service.dart';
import 'package:mouse_phone/model_view/connection_model_view.dart';
import 'package:mouse_phone/widget/error_message.dart';
import 'package:mouse_phone/widget/rgb_border.dart';
import 'package:mouse_phone/navigation/bottom_navigation.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Mouse extends StatefulWidget {
  const Mouse({super.key});

  @override
  State<Mouse> createState() => _MouseState();
}

class _MouseState extends State<Mouse> {
  late WebSocketModelView webSocketModelView;

  late ConnectionModelView connectionModelView;

  bool loading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        connectionModelView = Provider.of<ConnectionModelView>(
          context,
          listen: false,
        );

        getWebSocket(connectionModelView.connectionModel.ip);
      });
    });
  }

  void getWebSocket(String ip) async {
    webSocketModelView = WebSocketModelView(ws: WebSocketService(ip: ip));

    try {
      await webSocketModelView.initConnectionWithWebSocketService();

      setState(() {
        loading = false;
      });
    } catch (e) {
      print("Caiu em error");
      print("Não foi possível conectar ao servidor");

      webSocketModelView.disconnectWebSocketService();

      setState(() {
        loading = false;
        isError = true;
      });
    }
  }

  @override
  void dispose() {
    webSocketModelView.disconnectWebSocketService();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectionModelView modelView = Provider.of<ConnectionModelView>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            //Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              spacing: 10,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      loading || isError ? "Procurando" : "Conectado",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Observer(
                      builder: (_) => Text(
                        modelView.connectionModel.ip,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: loading || isError ? Colors.red : Color(0xFF00A843),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: loading
          ? Center(child: CircularProgressIndicator(color: Colors.white))
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: isError
                  ? ErrorMessage(
                      message:
                          "Não foi possível conectar ao desktop, confira o IP e tente novamente.",
                    )
                  : Column(
                      spacing: 30,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 25,
                          children: <Widget>[
                            Expanded(
                              child: RgbBorder(
                                child: GestureDetector(
                                  onTap: () {
                                    print("Left button pressed");
                                    //ws.sendDataToWs("leftButton: true");
                                    Map<String, dynamic> data = {
                                      "x": 0.0,
                                      "y": 0.0,
                                      "left": true,
                                      "right": false,
                                      "scrollUp": false,
                                      "scrollDown": false,
                                    };

                                    webSocketModelView.sendData(data);
                                  },
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Botão esquerdo",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            71,
                                            255,
                                            255,
                                            255,
                                          ),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: RgbBorder(
                                child: GestureDetector(
                                  onTap: () {
                                    print("Right button pressed");
                                    //ws.sendDataToWs("rifhtButton: true");
                                    Map<String, dynamic> data = {
                                      "x": 0.0,
                                      "y": 0.0,
                                      "left": false,
                                      "right": true,
                                      "scrollUp": false,
                                      "scrollDown": false,
                                    };

                                    webSocketModelView.sendData(data);
                                  },
                                  child: Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Botão direito",
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                            71,
                                            255,
                                            255,
                                            255,
                                          ),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 25,
                          children: <Widget>[
                            RgbBorder(
                              child: IconButton(
                                onPressed: () {
                                  print("Scroll up pressed");

                                  Map<String, dynamic> data = {
                                    "x": 0.0,
                                    "y": 0.0,
                                    "left": false,
                                    "right": false,
                                    "scrollUp": true,
                                    "scrollDown": false,
                                  };

                                  webSocketModelView.sendData(data);
                                },
                                icon: Icon(
                                  Icons.arrow_upward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            RgbBorder(
                              child: IconButton(
                                onPressed: () {
                                  print("Scroll down pressed");
                                  //ws.sendDataToWs("scrollDown: true");
                                  Map<String, dynamic> data = {
                                    "x": 0.0,
                                    "y": 0.0,
                                    "left": false,
                                    "right": false,
                                    "scrollUp": false,
                                    "scrollDown": true,
                                  };

                                  webSocketModelView.sendData(data);
                                },
                                icon: Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: RgbBorder(
                            child: GestureDetector(
                              onPanUpdate: (details) {
                                print(
                                  'dx: ${details.delta.dx}, dy: ${details.delta.dy}',
                                );
                                Map<String, dynamic> data = {
                                  "x": details.delta.dx,
                                  "y": details.delta.dy,
                                  "left": false,
                                  "right": false,
                                  "scrollUp": false,
                                  "scrollDown": false,
                                };

                                webSocketModelView.sendData(data);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  color: Colors.transparent,
                                ),
                                child: Center(
                                  child: Text(
                                    "Toque na área para mover o cursor",
                                    style: TextStyle(
                                      color: Color.fromARGB(71, 255, 255, 255),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
      backgroundColor: Color(0xFF0000000),
    );
  }
}
