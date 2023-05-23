import 'dart:convert';

import 'package:client/api/dto/response/product_projection.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:dio/dio.dart';

class ProductProjectionApi {
  static Future<ProductProjectionListResponse> productProjList() async {
    // try {
    var response = await 
    HttpUtil().get(
      'catalog/products/projections',
    );
    // if (response.statusCode == 200) {
    var jsonData = response.data;
    var res = ProductProjectionListResponse.fromJson(jsonData);
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }
}
