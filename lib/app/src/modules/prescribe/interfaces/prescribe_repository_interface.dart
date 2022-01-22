import 'package:payback/app/src/core/models/api_response.model.dart';

abstract class IPrescribeRepository {
  Future<ApiResponseModel?> getAllPrescribes({
    required context,
  });

  Future<ApiResponseModel?> addPrescribe({
    required context,
  });

  Future<ApiResponseModel?> updatePrescribe({
    required context,
  });

  Future<ApiResponseModel?> deletePrescribe({
    required context,
  });
}
