class ApiResponseModel<T> {
  T data;
  T? headers;
  int statusCode;

  ApiResponseModel({
    required this.data,
    required this.statusCode,
    this.headers,
  });
}
