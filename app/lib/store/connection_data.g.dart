// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectionData on ConnectionDataBase, Store {
  late final _$ipAtom = Atom(name: 'ConnectionDataBase.ip', context: context);

  @override
  String get ip {
    _$ipAtom.reportRead();
    return super.ip;
  }

  @override
  set ip(String value) {
    _$ipAtom.reportWrite(value, super.ip, () {
      super.ip = value;
    });
  }

  late final _$hostnameAtom = Atom(
    name: 'ConnectionDataBase.hostname',
    context: context,
  );

  @override
  String get hostname {
    _$hostnameAtom.reportRead();
    return super.hostname;
  }

  @override
  set hostname(String value) {
    _$hostnameAtom.reportWrite(value, super.hostname, () {
      super.hostname = value;
    });
  }

  late final _$portAtom = Atom(
    name: 'ConnectionDataBase.port',
    context: context,
  );

  @override
  int get port {
    _$portAtom.reportRead();
    return super.port;
  }

  @override
  set port(int value) {
    _$portAtom.reportWrite(value, super.port, () {
      super.port = value;
    });
  }

  late final _$ConnectionDataBaseActionController = ActionController(
    name: 'ConnectionDataBase',
    context: context,
  );

  @override
  void setIp(String value) {
    final _$actionInfo = _$ConnectionDataBaseActionController.startAction(
      name: 'ConnectionDataBase.setIp',
    );
    try {
      return super.setIp(value);
    } finally {
      _$ConnectionDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHostname(String value) {
    final _$actionInfo = _$ConnectionDataBaseActionController.startAction(
      name: 'ConnectionDataBase.setHostname',
    );
    try {
      return super.setHostname(value);
    } finally {
      _$ConnectionDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPort(int value) {
    final _$actionInfo = _$ConnectionDataBaseActionController.startAction(
      name: 'ConnectionDataBase.setPort',
    );
    try {
      return super.setPort(value);
    } finally {
      _$ConnectionDataBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ip: ${ip},
hostname: ${hostname},
port: ${port}
    ''';
  }
}
