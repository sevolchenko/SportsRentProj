import 'package:client/api/apis/product_api.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';

class ProductRepository {
  final ProductApi _productApi = ProductApi();

  Future<ProductResponse> getProductById(int id) async {
    return await _productApi.productById(id);
  }

  Future<List<ProductResponse>> getProducts() async {
    return await _productApi.products();
  }

  Future<ProductPreviewResponse> getProductPreviewById(int productId) async {
    return await _productApi.productPreview(productId);
  }

  Future<List<ProductPreviewResponse>> getProductsPreviews() async {
    return await _productApi.productsPreviews();
  }

  Future<List<SizeResponse>> getProductSizes(int productId) async {
    return await _productApi.productSizes(productId);
  }

  Future<void> sizeCountUpdate(int id, Map<String, dynamic> size) async {
    await _productApi.sizeCountUpdate(id, size);
  }

  Future<void> sizeDelete(int id, Map<String, dynamic> size) async {
    await _productApi.sizeDelete(id, size);
  }

  Future<void> sizeCreate(int id, Map<String, dynamic> size) async {
    await _productApi.sizeCreate(id, size);
  }

  Future<void> productCreate(Map<String, dynamic> body) async {
    await _productApi.productCreate(body);
  }

  Future<void> productDelete(int id) async {
    await _productApi.productDelete(id);
  }


}
