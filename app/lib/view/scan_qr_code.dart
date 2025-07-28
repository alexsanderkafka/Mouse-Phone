import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mouse_phone/store/connection_data.dart';
import 'package:mouse_phone/view/mouse.dart';
import 'package:provider/provider.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  //final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  String? alertMessage;

  late ConnectionData connectionData;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectionData = Provider.of<ConnectionData>(context, listen: false);
    });
  }

  void _handleBarcode(BarcodeCapture barcodes) {
    Barcode? barcode = barcodes.barcodes.firstOrNull;

    if (barcode != null) {
      setState(() {
        alertMessage = "Conexão iniciada com o computador";
      });

      if (barcode.rawValue == null) {
        setState(() {
          alertMessage = "QR code inválido!";
        });

        return;
      }

      var json = jsonDecode(barcode.rawValue!);

      print(json);

      connectionData.setIp(json['ip']);
      connectionData.setHostname(json['hostname']);

      print("Ip do pc: ${json['ip']}");
      print("Ip do pc: ${json['hostname']}");

      Navigator.push(context, MaterialPageRoute(builder: (context) => Mouse()));

      return;
    }

    setState(() {
      alertMessage = "Não foi possível iniciar a conexão com o computador!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF000000),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: <Widget>[
          MobileScanner(onDetect: _handleBarcode),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        alertMessage ??
                            'Escaneie o QR code para conexão com o computador!',
                        overflow: TextOverflow.fade,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
