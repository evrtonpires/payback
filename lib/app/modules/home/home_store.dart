import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:payback/app/modules/shared/auth/auth_controller.dart';
import 'package:payback/app/modules/shared/models/user/user_model.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  _HomeStoreBase({
    required this.authController,
  });

  final AuthController authController;

//----------------------------------------------------------------------------
  @observable
  int currentTabCardAnimal = 0;

  @action
  void setCurrentTabCardAnimal(int newTab) => currentTabCardAnimal = newTab;

//----------------------------------------------------------------------------
  @observable
  int currentTabItensAnimal = 0;

  @action
  void setCurrentTabItensAnimal(int newTab) => currentTabItensAnimal = newTab;

//----------------------------------------------------------------------------
  @observable
  UserModel user = UserModel.padrao();

//----------------------------------------------------------------------------
  @observable
  String? img;

//----------------------------------------------------------------------------
  @observable
  bool isLoading = false;

  @action
  void changeIsLoading() {
    isLoading = !isLoading;
  }

//----------------------------------------------------------------------------
  @observable
  String changeNamedPet = '';

//----------------------------------------------------------------------------

  @action
  Future<dynamic> setImg() async {
    try {
      await ImagePicker()
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      )
          .then((value) {
        img = value!.path;
      });
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------

  @action
  void getUser() {
    user = authController.userModel!;
  }

//----------------------------------------------------------------------------
}
