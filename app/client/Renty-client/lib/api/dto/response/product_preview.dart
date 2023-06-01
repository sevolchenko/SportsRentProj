import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';

class ProductPreviewResponse {
  final int productId;
  final String name;
  final int price;
  final bool busyNow;
  final CategoryPreviewResponse category;
  final ImageResponse? mainImage;

  ProductPreviewResponse({
    required this.productId,
    required this.name,
    required this.price,
    required this.busyNow,
    required this.category,
    this.mainImage,
  });

  factory ProductPreviewResponse.fromJson(Map<String, dynamic> json) {
    return ProductPreviewResponse(
      productId: json['product_id'],
      name: json['name'],
      price: json['price'],
      busyNow: json['busy_now'],
      category: json['category'] =
          CategoryPreviewResponse.fromJson(json['category']),
      mainImage: json['main_image'] == null
          ? null
          : ImageResponse.fromJson(json['main_image']),
    );
  }
}
