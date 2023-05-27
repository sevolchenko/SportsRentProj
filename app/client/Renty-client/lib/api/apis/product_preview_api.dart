import 'dart:convert';

import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:dio/dio.dart';

class ProductPreviewApi {
  Future<List<ProductPreviewResponse>> productProjList() async {
    // try {
    var response = await HttpUtil().get(
      'catalog/products/previews',
    );
    // if (response.statusCode == 200) {
    var jsonData = response.data;
    var res = List<ProductPreviewResponse>.from(
        jsonData.map((x) => ProductPreviewResponse.fromJson(x)));
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }
}
