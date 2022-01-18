import 'package:mobx/mobx.dart';

part 'remedy_store.g.dart';

class RemedyStore = _RemedyStoreBase with _$RemedyStore;

abstract class _RemedyStoreBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
