import '../models/sign_up_formulary_model.dart';
import '../../../core/models/login_response_model.dart';

abstract class ISignUpRepository {
  Future<LoginResponseModel?> getSignUp({
    required context,
    required SignUpFormularyModel signUpFormularyModel,
  });
}
