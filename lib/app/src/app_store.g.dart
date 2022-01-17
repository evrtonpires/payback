// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$userModelAtom = Atom(name: '_AppStoreBase.userModel');

  @override
  UserModel get userModel {
    _$userModelAtom.reportRead();
    return super.userModel;
  }

  @override
  set userModel(UserModel value) {
    _$userModelAtom.reportWrite(value, super.userModel, () {
      super.userModel = value;
    });
  }

  final _$isDeviceConnectedAtom = Atom(name: '_AppStoreBase.isDeviceConnected');

  @override
  bool get isDeviceConnected {
    _$isDeviceConnectedAtom.reportRead();
    return super.isDeviceConnected;
  }

  @override
  set isDeviceConnected(bool value) {
    _$isDeviceConnectedAtom.reportWrite(value, super.isDeviceConnected, () {
      super.isDeviceConnected = value;
    });
  }

  final _$beforeIsDeviceConnectedAtom =
      Atom(name: '_AppStoreBase.beforeIsDeviceConnected');

  @override
  bool get beforeIsDeviceConnected {
    _$beforeIsDeviceConnectedAtom.reportRead();
    return super.beforeIsDeviceConnected;
  }

  @override
  set beforeIsDeviceConnected(bool value) {
    _$beforeIsDeviceConnectedAtom
        .reportWrite(value, super.beforeIsDeviceConnected, () {
      super.beforeIsDeviceConnected = value;
    });
  }

  @override
  String toString() {
    return '''
userModel: ${userModel},
isDeviceConnected: ${isDeviceConnected},
beforeIsDeviceConnected: ${beforeIsDeviceConnected}
    ''';
  }
}
