import 'dart:io';

import 'package:payback/app/src/core/models/api_response.model.dart';

abstract class IPrescribeRepository {
  Future<ApiResponseModel?> getAllPrescribes({
    required context,
  });

  Future<ApiResponseModel?> addPrescribe({
    required context,
    required dynamic data,
  });

  Future<ApiResponseModel?> updatePrescribe({
    required context,
  });

  Future<ApiResponseModel?> deletePrescribe({
    required context,
  });

  Future<ApiResponseModel?> uploadFormData({
    required context,
    required File file,
    required int precripId,
    required Function(int send, int total) onSendProgress,
  });
}
