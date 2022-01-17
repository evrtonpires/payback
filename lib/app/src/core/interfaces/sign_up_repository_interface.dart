import '../../modules/sign_up/models/sign_up_formulary_model.dart';
import '../models/login_response_model.dart';

abstract class ISignUpRepository {
  Future<LoginResponseModel?> getSignUp({
    required context,
    required SignUpFormularyModel signUpFormularyModel,
  });
}
