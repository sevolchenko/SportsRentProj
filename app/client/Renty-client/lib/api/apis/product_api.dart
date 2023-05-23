import 'package:client/api/dto/response/product.dart';
import 'package:client/common/utils/http_util.dart';

class ProductApi {
  static Future<ProductResponse> productById(int productId) async {
    // try {
    var path = 'catalog/products/${productId}';
    var response = await HttpUtil().get(
      path,
    );
    // if (response.statusCode == 200) {
    var jsonData = response.data;
    var res = ProductResponse.fromJson(jsonData);
    print(res);
    return res;
    // }
    // } on DioError catch (e) {
    // print(e.message);
    // }
  }
}
