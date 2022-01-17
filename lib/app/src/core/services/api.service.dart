import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../routes/api.routes.dart';
import '../models/api_response.model.dart';
import '../interfaces/api.interface.dart';

class ApiService implements IApi {
  ApiService({required this.dio}) {
    dio.options.baseUrl = ApiRoutes.baseUrl;
    dio.options.followRedirects = false;
    dio.options.validateStatus = (status) => status! < 5000;
    dio.options.sendTimeout = 60 * 1000;
    dio.options.receiveTimeout = 60 * 1000;
  }

  final Dio dio;

  @override
  Future<ApiResponseModel> call(
      {required EApiType type,
      required String url,
      Map<String, dynamic>? data,
      Map<String, dynamic>? headers}) async {
    if (headers != null) {
      dio.options.headers = headers;
    } else {
      dio.options.headers.clear();
    }

    Response response;
    switch (type) {
      case EApiType.get:
        response = await dio.get(url.contains("http") ? url : "/$url",
            queryParameters: data);
        break;
      case EApiType.post:
        response = await dio.post("/$url", data: jsonEncode(data));
        break;
      case EApiType.put:
        response = await dio.put("/$url", data: jsonEncode(data));
        break;
      case EApiType.patch:
        response = await dio.patch("/$url", data: jsonEncode(data));
        break;
      case EApiType.delete:
        response = await dio.delete("/$url", data: jsonEncode(data));
        break;
      case EApiType.head:
        response = await dio.head(url.contains("http") ? url : "/$url",
            queryParameters: data);
        break;
    }

    log("======start======");
    log("url: ${dio.options.baseUrl}/$url");
    log("paramsData: $data");
    log("headers: ${dio.options.headers}");
    log("statusCode: ${response.statusCode}");
    print("responseData: ${response.data}");
    log("=======end=======");

    return ApiResponseModel(
      data: response.data,
      headers: response.headers,
      statusCode: response.statusCode!,
    );
  }
}
