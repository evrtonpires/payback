import 'package:mobx/mobx.dart';

part 'prescribe_store.g.dart';

class PrescribeStore = _PrescribeStoreBase with _$PrescribeStore;

abstract class _PrescribeStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
