import 'package:client/api/apis/product_api.dart';
import 'package:client/api/dto/response/product.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();

  Future<ProductResponse> getProductById(int id) {
    return _productApi.productById(id);
  }
}
