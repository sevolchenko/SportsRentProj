import 'package:client/api/dto/response/image.dart';

class ProductPreviewResponse {
  final int productId;
  final String name;
  final ImageResponse mainImage;

  ProductPreviewResponse(
      {required this.productId, required this.name, required this.mainImage});

  factory ProductPreviewResponse.fromJson(Map<String, dynamic> json) {
    return ProductPreviewResponse(
      productId: json['product_id'],
      name: json['name'],
      mainImage: json['main_image'],
    );
  }
}
