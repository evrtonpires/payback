// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescribe_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PrescribeStore on _PrescribeStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_PrescribeStoreBase.isLoading');

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

  final _$sendMessageAtom = Atom(name: '_PrescribeStoreBase.sendMessage');

  @override
  String? get sendMessage {
    _$sendMessageAtom.reportRead();
    return super.sendMessage;
  }

  @override
  set sendMessage(String? value) {
    _$sendMessageAtom.reportWrite(value, super.sendMessage, () {
      super.sendMessage = value;
    });
  }

  final _$imageAtom = Atom(name: '_PrescribeStoreBase.image');

  @override
  File? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(File? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  final _$codeAtom = Atom(name: '_PrescribeStoreBase.code');

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
      Atom(name: '_PrescribeStoreBase.messageCodeError');

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

  final _$listDrugSelectedAtom =
      Atom(name: '_PrescribeStoreBase.listDrugSelected');

  @override
  List<DrugModel> get listDrugSelected {
    _$listDrugSelectedAtom.reportRead();
    return super.listDrugSelected;
  }

  @override
  set listDrugSelected(List<DrugModel> value) {
    _$listDrugSelectedAtom.reportWrite(value, super.listDrugSelected, () {
      super.listDrugSelected = value;
    });
  }

  final _$drugsAtom = Atom(name: '_PrescribeStoreBase.drugs');

  @override
  List<DrugModel> get drugs {
    _$drugsAtom.reportRead();
    return super.drugs;
  }

  @override
  set drugs(List<DrugModel> value) {
    _$drugsAtom.reportWrite(value, super.drugs, () {
      super.drugs = value;
    });
  }

  final _$haveDrugSelectedAtom =
      Atom(name: '_PrescribeStoreBase.haveDrugSelected');

  @override
  bool get haveDrugSelected {
    _$haveDrugSelectedAtom.reportRead();
    return super.haveDrugSelected;
  }

  @override
  set haveDrugSelected(bool value) {
    _$haveDrugSelectedAtom.reportWrite(value, super.haveDrugSelected, () {
      super.haveDrugSelected = value;
    });
  }

  final _$_PrescribeStoreBaseActionController =
      ActionController(name: '_PrescribeStoreBase');

  @override
  void setCode(String newCode) {
    final _$actionInfo = _$_PrescribeStoreBaseActionController.startAction(
        name: '_PrescribeStoreBase.setCode');
    try {
      return super.setCode(newCode);
    } finally {
      _$_PrescribeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
sendMessage: ${sendMessage},
image: ${image},
code: ${code},
messageCodeError: ${messageCodeError},
listDrugSelected: ${listDrugSelected},
drugs: ${drugs},
haveDrugSelected: ${haveDrugSelected}
    ''';
  }
}
