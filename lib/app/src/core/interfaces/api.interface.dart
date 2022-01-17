import '../models/api_response.model.dart';

abstract class IApi {
  Future<ApiResponseModel> call({
    required EApiType type,
    required String url,
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  });
}

enum EApiType { get, post, put, patch, delete, head }
