import 'package:payback/app/src/core/models/api_response.model.dart';

import '../models/login_formulary_model.dart';

abstract class ILoginRepository {
  Future<ApiResponseModel?> getLogin({
    required LoginFormularyModel loginFormulary,
    required context,
  });
}
