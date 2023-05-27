import 'package:client/api/dto/response/product.dart';
import 'package:client/common/utils/http_util.dart';

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
}
