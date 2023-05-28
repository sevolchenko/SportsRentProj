import 'package:client/api/dto/request/size.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/common/utils/http_util.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';
import 'package:dio/dio.dart';

class ProductApi {
  Future<ProductResponse> productById(int productId) async {
    // try {
    var path = 'catalog/products/${productId}';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = ProductResponse.fromJson(jsonData);
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }

  Future<List<ProductResponse>> products() async {
    var path = 'catalog/products';
    var response = await HttpUtil().get(
      path,
    );
    var jsonData = response.data;
    var res = List<ProductResponse>.from(
        jsonData.map((x) => ProductResponse.fromJson(x)));
    return res;
  }

  Future<int?> sizeCountUpdate(
      int productId, Map<String, dynamic> size) async {
    var path = 'catalog/products/${productId}/sizes';
    var statusCode = await HttpUtil().patch(path, size);
    try {
      if (statusCode == 200) {
        return statusCode;
      }
    } on DioError catch (e) {
      toastInfo(msg: e.toString());
    }
    return null;
  }

  Future<int?> sizeDelete(
      int productId, Map<String, dynamic> size) async {
    var path = 'catalog/products/${productId}/sizes';
    var statusCode = await HttpUtil().delete(path, size);
    try {
      if (statusCode == 200) {
        return statusCode;
      }
    } on DioError catch (e) {
      toastInfo(msg: e.toString());
    }
    return null;
  }
}
