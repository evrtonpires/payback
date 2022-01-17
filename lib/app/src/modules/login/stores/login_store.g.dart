// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on LoginStoreBase, Store {
  final _$cnpjAtom = Atom(name: 'LoginStoreBase.cnpj');

  @override
  String? get cnpj {
    _$cnpjAtom.reportRead();
    return super.cnpj;
  }

  @override
  set cnpj(String? value) {
    _$cnpjAtom.reportWrite(value, super.cnpj, () {
      super.cnpj = value;
    });
  }

  final _$messageCnpjErrorAtom = Atom(name: 'LoginStoreBase.messageCnpjError');

  @override
  String? get messageCnpjError {
    _$messageCnpjErrorAtom.reportRead();
    return super.messageCnpjError;
  }

  @override
  set messageCnpjError(String? value) {
    _$messageCnpjErrorAtom.reportWrite(value, super.messageCnpjError, () {
      super.messageCnpjError = value;
    });
  }

  final _$userAtom = Atom(name: 'LoginStoreBase.user');

  @override
  String? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(String? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$messageLoginErrorAtom =
      Atom(name: 'LoginStoreBase.messageLoginError');

  @override
  String? get messageLoginError {
    _$messageLoginErrorAtom.reportRead();
    return super.messageLoginError;
  }

  @override
  set messageLoginError(String? value) {
    _$messageLoginErrorAtom.reportWrite(value, super.messageLoginError, () {
      super.messageLoginError = value;
    });
  }

  final _$passwordAtom = Atom(name: 'LoginStoreBase.password');

  @override
  String? get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String? value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$messagePasswordErrorAtom =
      Atom(name: 'LoginStoreBase.messagePasswordError');

  @override
  String? get messagePasswordError {
    _$messagePasswordErrorAtom.reportRead();
    return super.messagePasswordError;
  }

  @override
  set messagePasswordError(String? value) {
    _$messagePasswordErrorAtom.reportWrite(value, super.messagePasswordError,
        () {
      super.messagePasswordError = value;
    });
  }

  final _$isLoadingAtom = Atom(name: 'LoginStoreBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$keepConnectedAtom = Atom(name: 'LoginStoreBase.keepConnected');

  @override
  bool get keepConnected {
    _$keepConnectedAtom.reportRead();
    return super.keepConnected;
  }

  @override
  set keepConnected(bool value) {
    _$keepConnectedAtom.reportWrite(value, super.keepConnected, () {
      super.keepConnected = value;
    });
  }

  final _$autenticateAsyncAction = AsyncAction('LoginStoreBase.autenticate');

  @override
  Future<void> autenticate(BuildContext context) {
    return _$autenticateAsyncAction.run(() => super.autenticate(context));
  }

  final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase');

  @override
  void setCnpj(String newCnpj) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setCnpj');
    try {
      return super.setCnpj(newCnpj);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLogin(String newUser) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setLogin');
    try {
      return super.setLogin(newUser);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String newPassword) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setPassword');
    try {
      return super.setPassword(newPassword);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cnpj: ${cnpj},
messageCnpjError: ${messageCnpjError},
user: ${user},
messageLoginError: ${messageLoginError},
password: ${password},
messagePasswordError: ${messagePasswordError},
isLoading: ${isLoading},
keepConnected: ${keepConnected}
    ''';
  }
}
