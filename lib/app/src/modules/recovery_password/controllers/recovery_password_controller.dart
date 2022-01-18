import '../../../app_store.dart';
import '../interfaces/recovery_password_repository_interface.dart';

class RecoveryPasswordController {
  String keySTR = "4Rtv9UH56xWtAyNcS5Yr3jrPmWs26Wa6";
  String ivSTR = "anhsudrmfo29xuc8";

  RecoveryPasswordController(this._recoveryPasswordRepository, this._appStore);

  final IRecoveryPasswordRepository _recoveryPasswordRepository;

  final AppStore _appStore;

  AppStore get appStore => _appStore;

  //----------------------------------------------------------------------------
  Future<bool?> recoveryPasswordValidadeEmail({
    required String email,
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();
      if (connectivityResult) {
        final validate = await _recoveryPasswordRepository
            .getRecoveryPasswordValidadeEmail(email: email, context: context);
        if (validate) {
          return true;
        }
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------
  Future<bool> recoveryPassword({
    required String password,
    required String code,
    required String email,
    required context,
  }) async {
    try {
      var connectivityResult = await _appStore.checkConnectivity();
      if (connectivityResult) {
        final success = await _recoveryPasswordRepository.getRecoveryPassword(
          context: context,
          password: password,
          code: code,
        );
        if (success) {
          _appStore.saveUserSharedPrefs(
              stringValue: 'passwordValue', data: password);
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

//----------------------------------------------------------------------------

//   //----------------------------------------------------------------------------
//   Future<bool?> signUp({
//     required UserModel user,
//     required context,
//   }) async {
//     try {
//       var connectivityResult = await checkConnectivity();
//
//       if (connectivityResult) {
//         user.password = encryptFunction(user.password);
//         userModel = await _loginRepository.getSignUp(
//             userModel: user, authController: Modular.get(), context: context);
//         if (userModel != null) {
//           saveUserSharedPrefs(stringValue: 'userValue', data: userModel!.email);
//           saveUserSharedPrefs(
//               stringValue: 'passwordValue',
//               data: decryptFunction(userModel!.password));
//           return true;
//         } else {
//           awesomeDialogWidget(
//               context: context,
//               animType: AnimType.SCALE,
//               dialogType: DialogType.NO_HEADER,
//               title: 'Erro ao obter acesso',
//               text:
//                   'Caso tenha um cadastro conosco, ative sua internet e realize o login para termos os dados necessarios em nossa base local.\n\nCaso não tenha, obtenha um cadastro em nosso aplicativo para realizar o login.',
//               borderColor: Colors.red,
//               buttonColor: Colors.red.shade800,
//               btnOkOnPress: () {});
//
//           return false;
//         }
//       }
//     } catch (e) {
//       return false;
//     }
//   }
//

}
