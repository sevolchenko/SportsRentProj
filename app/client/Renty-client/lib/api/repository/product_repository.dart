import 'package:client/api/apis/product_api.dart';
import 'package:client/api/dto/request/size.dart';
import 'package:client/api/dto/response/product.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();

  Future<ProductResponse> getProductById(int id) {
    return _productApi.productById(id);
  }

  Future<List<ProductResponse>> getProducts() {
    return _productApi.products();
  }

  Future<int?> sizeCountUpdate(int id, Map<String, dynamic> size) {
    return _productApi.sizeCountUpdate(id, size);
  }
}
