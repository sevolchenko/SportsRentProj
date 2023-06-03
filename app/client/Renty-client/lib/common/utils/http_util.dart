import 'package:client/common/values/constant.dart';
import 'package:client/global.dart';
import 'package:dio/dio.dart';

class HttpUtil {
  static HttpUtil _instance = HttpUtil._internal();

  factory HttpUtil() {
    return _instance;
  }

  late Dio dio;

  // final String token =
  //     "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJzZS52b2xjaGVua29AeWEucnUiLCJyb2xlIjoiRU1QTE9ZRUUiLCJpYXQiOjE2ODUzMDg1MjksImV4cCI6MTY5MzA4NDUyOX0.PORl2S7ITzvjFzPSC5f0OPcNZcQDNAUKJ5XsjD1p3TJOhEPwr7ZG8Mdteqe7EVRl";
  //     "Bearer eyJhbGciOiJIUzM4NCJ9.eyJzdWIiOiJ2YWRpbTAyMTAxQGdtYWlsLmNvbSIsInJvbGUiOiJVU0VSIiwiaWF0IjoxNjg1NjYyMzU1LCJleHAiOjE2OTM0MzgzNTV9.3jAt9aYnFEiabmKPTDSVbim6rfq8uhj_ca41HHQ2Ipn060XsodOt_UgKmedaIrSs";
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

  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    var response = dio.get(
      path,
      queryParameters: queryParameters,
      options: getOptions(null),
    );
    return response;
  }

  Future post(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: getOptions(options),
    );
    return response.statusCode;
  }

  Future patch(String path,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options) async {
    var response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options),
    );
    return
    response
    .
    statusCode;
  }

  Future delete(String path,
      dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options) async {
    var response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: getOptions(options)
    );
    return response.statusCode;
  }

  Options getOptions(Options? options) {
    var headers = <String, dynamic>{};
    if (options != null && options.headers != null) {
      headers.addAll(options.headers!);
    }
    if (Global.storageService.isUserAuthenticated()) {
      headers['Authorization'] = Global.storageService.getUser()!.token;
    }
    headers['Content-Type'] = 'application/json';
    return Options(headers: headers);
  }
}
