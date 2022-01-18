import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  _HomeStoreBase();

//----------------------------------------------------------------------------

  @action
  Future<dynamic> setImg() async {
    try {
      await ImagePicker()
          .pickImage(
            source: ImageSource.gallery,
            imageQuality: 100,
          )
          .then((value) {});
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------
}
