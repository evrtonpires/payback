// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PointStore on _PointStoreBase, Store {
  final _$totalPointAtom = Atom(name: '_PointStoreBase.totalPoint');

  @override
  int get totalPoint {
    _$totalPointAtom.reportRead();
    return super.totalPoint;
  }

  @override
  set totalPoint(int value) {
    _$totalPointAtom.reportWrite(value, super.totalPoint, () {
      super.totalPoint = value;
    });
  }

  final _$_PointStoreBaseActionController =
      ActionController(name: '_PointStoreBase');

  @override
  void totalPoints() {
    final _$actionInfo = _$_PointStoreBaseActionController.startAction(
        name: '_PointStoreBase.totalPoints');
    try {
      return super.totalPoints();
    } finally {
      _$_PointStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getUndDrugs(int idDrug) {
    final _$actionInfo = _$_PointStoreBaseActionController.startAction(
        name: '_PointStoreBase.getUndDrugs');
    try {
      return super.getUndDrugs(idDrug);
    } finally {
      _$_PointStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
totalPoint: ${totalPoint}
    ''';
  }
}
