import 'package:mobx/mobx.dart';
import 'package:payback/app/src/modules/home/models/prescribe/drug_model.dart';
import 'package:payback/app/src/modules/home/models/prescribe/prescribe_model.dart';
import 'package:payback/app/src/modules/home/stores/prescribe/prescribe_store.dart';

part 'point_store.g.dart';

class PointStore = _PointStoreBase with _$PointStore;

abstract class _PointStoreBase with Store {
  _PointStoreBase({required this.prescribeStore});

  final PrescribeStore prescribeStore;

  @observable
  int totalPoint = 0;

  @action
  void totalPoints() {
    totalPoint = prescribeStore.prescribes.fold(
        0,
        (int previousValue, element) =>
            previousValue +
            (element.drugs.fold(
                    0,
                    (int? previousValue2, element2) =>
                        previousValue2! + element2.dots) ??
                0));
  }

  @action
  int getUndDrugs(int idDrug) {
    int qant = 0;
    for (PrescribeModel prescribe in prescribeStore.prescribes) {
      qant += prescribe.drugs.where((element) => element.id == idDrug).length;
    }
    return qant;
  }

  List<DrugModel> getListDistribuidor() {
    List<DrugModel> list = [];
    for (PrescribeModel prescribe in prescribeStore.prescribes) {
      for (DrugModel dru in prescribe.drugs) {
        if (list.where((element) => element.id == dru.id).isEmpty) {
          list.add(dru);
        }
      }
    }
    return list;
  }
}
