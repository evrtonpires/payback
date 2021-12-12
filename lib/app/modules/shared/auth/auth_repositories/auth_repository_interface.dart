import '../auth_controller.dart';

abstract class IAuthRepository {
  Future<dynamic> getLogin(
      {required String user,
      required String password,
      required AuthController authController,
      required context});

  Future<dynamic> getSignUp({
    required context,
    required dynamic userModel,
    required AuthController authController,
  });

  Future<bool> getRecoverPasswordValidadeEmail(
      {required String email, required context});

  Future<bool> getRecoveryPassword(
      {required context,
      required String password,
      required String passwordConfirmation,
      required String code});
}
