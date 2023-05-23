import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';

class ProductProjectionResponse {
  final int productId;
  final String name;
  final int price;
  final bool busyNow;
  final CategoryPreviewResponse category;
  final ImageResponse? mainImage;

  ProductProjectionResponse({
    required this.productId,
    required this.name,
    required this.price,
    required this.busyNow,
    required this.category,
    this.mainImage,
  });

  factory ProductProjectionResponse.fromJson(Map<String, dynamic> json) {
    return ProductProjectionResponse(
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

class ProductProjectionListResponse {
  final List<ProductProjectionResponse>? projections;
  final int? size;

  ProductProjectionListResponse({
    this.projections,
    this.size,
  });

  factory ProductProjectionListResponse.fromJson(Map<String, dynamic> json) {
    return ProductProjectionListResponse(
      projections: json['projections'] = List<ProductProjectionResponse>.from(
          json['projections']
              .map((x) => ProductProjectionResponse.fromJson(x))),
      size: json['size'],
    );
  }
}
