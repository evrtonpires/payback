// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recovery_password_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RecoveryPasswordStore on _RecoveryPasswordStoreBase, Store {
  final _$isValidateAtom = Atom(name: '_RecoveryPasswordStoreBase.isValidate');

  @override
  bool get isValidate {
    _$isValidateAtom.reportRead();
    return super.isValidate;
  }

  @override
  set isValidate(bool value) {
    _$isValidateAtom.reportWrite(value, super.isValidate, () {
      super.isValidate = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_RecoveryPasswordStoreBase.isLoading');

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

  final _$keepConnectedAtom =
      Atom(name: '_RecoveryPasswordStoreBase.keepConnected');

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

  final _$emailAtom = Atom(name: '_RecoveryPasswordStoreBase.email');

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$messageEmailErrorAtom =
      Atom(name: '_RecoveryPasswordStoreBase.messageEmailError');

  @override
  String? get messageEmailError {
    _$messageEmailErrorAtom.reportRead();
    return super.messageEmailError;
  }

  @override
  set messageEmailError(String? value) {
    _$messageEmailErrorAtom.reportWrite(value, super.messageEmailError, () {
      super.messageEmailError = value;
    });
  }

  final _$passwordAtom = Atom(name: '_RecoveryPasswordStoreBase.password');

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
      Atom(name: '_RecoveryPasswordStoreBase.messagePasswordError');

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

  final _$passwordConfirmationAtom =
      Atom(name: '_RecoveryPasswordStoreBase.passwordConfirmation');

  @override
  String? get passwordConfirmation {
    _$passwordConfirmationAtom.reportRead();
    return super.passwordConfirmation;
  }

  @override
  set passwordConfirmation(String? value) {
    _$passwordConfirmationAtom.reportWrite(value, super.passwordConfirmation,
        () {
      super.passwordConfirmation = value;
    });
  }

  final _$messagePasswordConfirmationErrorAtom =
      Atom(name: '_RecoveryPasswordStoreBase.messagePasswordConfirmationError');

  @override
  String? get messagePasswordConfirmationError {
    _$messagePasswordConfirmationErrorAtom.reportRead();
    return super.messagePasswordConfirmationError;
  }

  @override
  set messagePasswordConfirmationError(String? value) {
    _$messagePasswordConfirmationErrorAtom
        .reportWrite(value, super.messagePasswordConfirmationError, () {
      super.messagePasswordConfirmationError = value;
    });
  }

  final _$codeAtom = Atom(name: '_RecoveryPasswordStoreBase.code');

  @override
  String? get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String? value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$messageCodeErrorAtom =
      Atom(name: '_RecoveryPasswordStoreBase.messageCodeError');

  @override
  String? get messageCodeError {
    _$messageCodeErrorAtom.reportRead();
    return super.messageCodeError;
  }

  @override
  set messageCodeError(String? value) {
    _$messageCodeErrorAtom.reportWrite(value, super.messageCodeError, () {
      super.messageCodeError = value;
    });
  }

  final _$autenticateEmailAsyncAction =
      AsyncAction('_RecoveryPasswordStoreBase.autenticateEmail');

  @override
  Future<void> autenticateEmail(BuildContext context) {
    return _$autenticateEmailAsyncAction
        .run(() => super.autenticateEmail(context));
  }

  final _$autenticateAsyncAction =
      AsyncAction('_RecoveryPasswordStoreBase.autenticate');

  @override
  Future<bool?> autenticate(BuildContext context) {
    return _$autenticateAsyncAction.run(() => super.autenticate(context));
  }

  final _$_RecoveryPasswordStoreBaseActionController =
      ActionController(name: '_RecoveryPasswordStoreBase');

  @override
  void setEmail(String newEmail) {
    final _$actionInfo = _$_RecoveryPasswordStoreBaseActionController
        .startAction(name: '_RecoveryPasswordStoreBase.setEmail');
    try {
      return super.setEmail(newEmail);
    } finally {
      _$_RecoveryPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String newPassword) {
    final _$actionInfo = _$_RecoveryPasswordStoreBaseActionController
        .startAction(name: '_RecoveryPasswordStoreBase.setPassword');
    try {
      return super.setPassword(newPassword);
    } finally {
      _$_RecoveryPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPasswordConfirmation(String newPasswordConfirmation) {
    final _$actionInfo =
        _$_RecoveryPasswordStoreBaseActionController.startAction(
            name: '_RecoveryPasswordStoreBase.setPasswordConfirmation');
    try {
      return super.setPasswordConfirmation(newPasswordConfirmation);
    } finally {
      _$_RecoveryPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCode(String newCode) {
    final _$actionInfo = _$_RecoveryPasswordStoreBaseActionController
        .startAction(name: '_RecoveryPasswordStoreBase.setCode');
    try {
      return super.setCode(newCode);
    } finally {
      _$_RecoveryPasswordStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isValidate: ${isValidate},
isLoading: ${isLoading},
keepConnected: ${keepConnected},
email: ${email},
messageEmailError: ${messageEmailError},
password: ${password},
messagePasswordError: ${messagePasswordError},
passwordConfirmation: ${passwordConfirmation},
messagePasswordConfirmationError: ${messagePasswordConfirmationError},
code: ${code},
messageCodeError: ${messageCodeError}
    ''';
  }
}
