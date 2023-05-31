import 'package:client/common/values/constant.dart';
import 'package:client/global.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();
  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  HttpUtil._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppConstants.SERVER_API_URL,
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
      headers: {},
      contentType: "application/json: charset=utf-8",
      responseType: ResponseType.json,
    );
    dio = Dio(options);
  }

  Future get(String path) async {
    var response = dio.get(
      path,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzZS52b2xjaGVua29AeWEucnUiLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE2ODUzMDg1MjksImV4cCI6MTY5MzA4NDUyOX0.PORl2S7ITzvjFzPSC5f0OPcNZcQDNAUKJ5XsjD1p3TJOhEPwr7ZG8Mdteqe7EVRl",
      }),
    );
    return response;
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.headers = requestOptions.headers ?? {};
    Map<String, dynamic>? authorization = getAuthorizationHeader();
    if (authorization != null) {
      requestOptions.headers!.addAll(authorization);
    }
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      // options: requestOptions,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzZS52b2xjaGVua29AeWEucnUiLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE2ODUzMDg1MjksImV4cCI6MTY5MzA4NDUyOX0.PORl2S7ITzvjFzPSC5f0OPcNZcQDNAUKJ5XsjD1p3TJOhEPwr7ZG8Mdteqe7EVRl",
      }),
    );
    return response;
  }

  Future patch(String path, dynamic data) async {
    var response = await dio.patch(
      path,
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzZS52b2xjaGVua29AeWEucnUiLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE2ODUzMDg1MjksImV4cCI6MTY5MzA4NDUyOX0.PORl2S7ITzvjFzPSC5f0OPcNZcQDNAUKJ5XsjD1p3TJOhEPwr7ZG8Mdteqe7EVRl",
      }),
    );
    return response.statusCode;
  }

  Future delete(String path, dynamic data) async {
    var response = await dio.delete(
      path,
      data: data,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization":
            "eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzZS52b2xjaGVua29AeWEucnUiLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE2ODUzMDg1MjksImV4cCI6MTY5MzA4NDUyOX0.PORl2S7ITzvjFzPSC5f0OPcNZcQDNAUKJ5XsjD1p3TJOhEPwr7ZG8Mdteqe7EVRl",
      }),
    );
    return response.statusCode;
  }

  Map<String, dynamic> getAuthorizationHeader() {
    var headers = <String, dynamic>{};
    var accessToken = Global.storageService.getUserToken();
    if (accessToken.isNotEmpty) {
      headers['Authorization'] = accessToken;
    }
    return headers;
  }
}
