abstract class IRecoveryPasswordRepository {
  Future<bool> getRecoveryPasswordValidadeEmail({
    required String email,
    required context,
  });

  Future<bool> getRecoveryPassword({
    required context,
    required String password,
    required String code,
  });
}
