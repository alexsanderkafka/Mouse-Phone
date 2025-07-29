// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_model_view.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectionModelView on ConnectionModelViewBase, Store {
  late final _$connectionModelAtom = Atom(
    name: 'ConnectionModelViewBase.connectionModel',
    context: context,
  );

  @override
  ConnectionModel get connectionModel {
    _$connectionModelAtom.reportRead();
    return super.connectionModel;
  }

  @override
  set connectionModel(ConnectionModel value) {
    _$connectionModelAtom.reportWrite(value, super.connectionModel, () {
      super.connectionModel = value;
    });
  }

  late final _$setConnectionModelAsyncAction = AsyncAction(
    'ConnectionModelViewBase.setConnectionModel',
    context: context,
  );

  @override
  Future<void> setConnectionModel() {
    return _$setConnectionModelAsyncAction.run(
      () => super.setConnectionModel(),
    );
  }

  late final _$ConnectionModelViewBaseActionController = ActionController(
    name: 'ConnectionModelViewBase',
    context: context,
  );

  @override
  void setIp(String value) {
    final _$actionInfo = _$ConnectionModelViewBaseActionController.startAction(
      name: 'ConnectionModelViewBase.setIp',
    );
    try {
      return super.setIp(value);
    } finally {
      _$ConnectionModelViewBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHostname(String value) {
    final _$actionInfo = _$ConnectionModelViewBaseActionController.startAction(
      name: 'ConnectionModelViewBase.setHostname',
    );
    try {
      return super.setHostname(value);
    } finally {
      _$ConnectionModelViewBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
connectionModel: ${connectionModel}
    ''';
  }
}
