import '../models/api_response.model.dart';

abstract class IApi {
  Future<ApiResponseModel> call({
    required EApiType type,
    required String url,
    dynamic data,
    Map<String, dynamic>? headers,
    Function(int, int)? onSendProgress,
  });
}

enum EApiType { get, post, put, patch, delete, head }
