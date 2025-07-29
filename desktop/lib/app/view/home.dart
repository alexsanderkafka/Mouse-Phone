import 'package:desktop/server/ws_server.dart';
import 'package:desktop/app/services/qrcode.dart';
import 'package:desktop/app/services/system_infos.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;
  String? systemIp;
  String hostname = "";
  final int port = 8888;

  late WebSocketServer ws;

  //0xFF00A84

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ip = await SystemInfos().getSystemIp();

      setState(() {
        systemIp = ip;
      });
    });

    hostname = SystemInfos().getHostname();
    ws = WebSocketServer(port: port);
    ws.init();
  }

  Widget renderQrCode() {
    if (systemIp == null) {
      return CircularProgressIndicator(color: Colors.white);
    }

    return QrCode(systemIp!, hostname).generateQrCode();
  }

  Widget renderIp() {
    if (systemIp == null) {
      return Center(child: CircularProgressIndicator(color: Colors.white));
    }

    return Row(
      children: [
        Text(
          "mouse://",
          style: TextStyle(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.start,
        ),
        Text(
          "$systemIp",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(
        title: const Text(
          "Mouse Phone",
          style: TextStyle(color: Color(0xFFFFFFFFF)),
        ),
        backgroundColor: Color(0xFF0000000),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                        bottom: 15,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Row(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/mouse.png',
                                width: 62,
                                height: 62,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Controle seu mouse',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFFF),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Conecte-se ao seu computador',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFFF),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Text(
                            "Transforme seu celular em um mouse sem fio para controlar seu computador. Conecte-se via IP ou escaneie o código QR para começar a usar.",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFFFFFFFFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => setState(() => isExpanded = !isExpanded),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Veja o seu IP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.arrow_drop_up
                                      : Icons.arrow_drop_down,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          if (isExpanded)
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0xFFFFFFFFF),
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                child: renderIp(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      spacing: 30,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Faça a leitura desse QR code pelo app para conectar ao seu smartphone",
                          style: TextStyle(
                            color: Color(0xFFFFFFFFF),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        renderQrCode(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
