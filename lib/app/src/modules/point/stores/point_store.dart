import 'package:mobx/mobx.dart';

part 'point_store.g.dart';

class PointStore = _PointStoreBase with _$PointStore;

abstract class _PointStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
