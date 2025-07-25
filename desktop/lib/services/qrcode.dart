import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode {
  String ipAddress;
  String hostname;
  int port;

  QrCode(this.ipAddress, this.hostname, this.port);

  Widget generateQrCode() {
    Map<String, dynamic> jsonData = {
      'ip': ipAddress,
      'hostname': hostname,
      'port': port,
    };

    final String jsonString = jsonEncode(jsonData);

    return QrImageView(
      data: jsonString,
      version: QrVersions.auto,
      size: 200.0,
      backgroundColor: Colors.black,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
      dataModuleStyle: QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.circle,
        color: Colors.white,
      ),
      eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: Colors.white),
    );
  }
}
