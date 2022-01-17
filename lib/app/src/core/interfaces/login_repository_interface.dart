import '../models/login_response_model.dart';
import '../../modules/login/models/login_formulary_model.dart';

abstract class ILoginRepository {
  Future<LoginResponseModel?> getLogin({
    required LoginFormularyModel loginFormulary,
    required context,
  });
}
