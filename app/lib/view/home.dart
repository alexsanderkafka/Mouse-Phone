import 'package:flutter/material.dart';
import 'package:mouse_phone/model_view/connection_model_view.dart';
import 'package:mouse_phone/view/mouse.dart';
import 'package:mouse_phone/view/scan_qr_code.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;

  final TextEditingController _ipController = TextEditingController();

  late ConnectionModelView connectionModelView;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        connectionModelView = Provider.of<ConnectionModelView>(
          context,
          listen: false,
        );

        connectionModelView.setConnectionModel();
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    connectionModelView = Provider.of<ConnectionModelView>(
      context,
      listen: false,
    );
  }

  void connectionEventClick() {
    connectionModelView.setIp(_ipController.text);
    connectionModelView.setHostname("Desktop");

    Navigator.push(context, MaterialPageRoute(builder: (context) => Mouse()));
  }

  void verifyIp(BuildContext context) {
    String ip = _ipController.text;
    String message = "";

    if (ip.isEmpty) {
      message = "Informe um IP";
    }

    //|\d{4,12})
    final ipv4Regex = RegExp(r'^((\d{1,3}\.){3}\d{1,3}$)');

    if (!ipv4Regex.hasMatch(ip)) {
      message = "Informe um IP no formato correto. Ex: 192.168.0.1";
    }

    if (ip.contains('.')) {
      final parts = ip.split('.');
      if (parts.length != 4 ||
          parts.any((part) {
            final num = int.tryParse(part);
            return num == null || num < 0 || num > 255;
          })) {
        message = 'Informe um IP no formato correto. Ex: 192.168.0.1';
      }
    }

    if (message.isEmpty) {
      connectionEventClick();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget hasLastConnection() {
    if (connectionModelView.connectionModel.ip.isEmpty ||
        connectionModelView.connectionModel.hostname.isEmpty) {
      return Text(
        "Nenhuma conexão anterior encontrada",
        style: TextStyle(
          fontSize: 18,
          color: Color(0xFFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Última conexão",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      connectionModelView.connectionModel.hostname,
                      style: TextStyle(color: Color(0xFFFFFFFFF), fontSize: 14),
                    ),
                    Text(
                      "IP: ${connectionModelView.connectionModel.ip}",
                      style: TextStyle(
                        color: Color(0xFFFFFFFFF),
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Mouse()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 2,
                      ),
                      child: Icon(
                        Icons.compare_arrows,
                        color: Color(0xFF0000000),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        spacing: 15,
                        children: [
                          Row(
                            spacing: 15,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Image.asset(
                                'assets/icons/mouse.png',
                                width: 42,
                                height: 42,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Controle seu mouse',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFFF),
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Conecte-se ao seu computador',
                                    style: TextStyle(
                                      color: Color(0xFFFFFFFFF),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Transforme seu celular em um mouse sem fio para controlar seu computador. Conecte-se via IP ou escaneie o código QR para começar a usar.",
                            style: TextStyle(
                              fontSize: 16,
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
                                  'Entre com o IP manualmente',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
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
                            Column(
                              children: [
                                Divider(color: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 15,
                                  ),
                                  child: TextField(
                                    controller: _ipController,
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white30,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2.0,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF0000000),

                                      hintText: 'mouse://',
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => verifyIp(context),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Text(
                                        'Conectar',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanQRCode()),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Color(0xFFFFFFFFF), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      spacing: 5,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/qr_code_scan.png',
                          width: 32,
                          height: 32,
                        ),
                        Text(
                          "Escanear QR code",
                          style: TextStyle(
                            color: Color(0xFFFFFFFFF),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              hasLastConnection(),
            ],
          ),
        ),
      ),
    );
  }
}
