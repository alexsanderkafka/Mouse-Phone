import 'dart:io';

class SystemInfos {
  Future<String?> getSystemIp() async {
    try {
      String ipAddress = '';

      for (var interface in await NetworkInterface.list()) {
        for (var addr in interface.addresses) {
          if (addr.type == InternetAddressType.IPv4) {
            ipAddress = addr.address;
            break;
          }
        }
      }

      if (ipAddress.isEmpty) {
        print('No IPv4 address found');
        return null;
        //throw Exception('No IPv4 address found');
      }

      return ipAddress;
    } catch (e) {
      print("Error getting system IP: $e");
      return null;
    }
  }

  String getHostname() {
    String hostname = Platform.localHostname;

    return hostname.isNotEmpty ? hostname : 'Unknown Hostname';
  }
}
