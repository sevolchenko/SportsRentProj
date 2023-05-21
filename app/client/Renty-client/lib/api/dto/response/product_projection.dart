import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';

class ProductProjection {
  final int productId;
  final String name;
  final int price;
  final bool busyNow;
  final CategoryResponse category;
  final ImageResponse mainImage;

  ProductProjection({
    required this.productId,
    required this.name,
    required this.price,
    required this.busyNow,
    required this.category,
    required this.mainImage,
  });

  factory ProductProjection.fromJson(Map<String, dynamic> json) {
    return ProductProjection(
        productId: json['product_id'],
        name: json['name'],
        price: json['price'],
        busyNow: json['busy_now'],
        category: json['category'],
        mainImage: json['main_image'],
        );
  }
}

class ListProductProjection {
  final List<ProductProjection> projections;
  final int size;

  ListProductProjection({
    required this.projections,
    required this.size,
  });

  factory ListProductProjection.fromJson(Map<String, dynamic> json) {
    return ListProductProjection(
      projections: json['projections'],
      size: json['size'],
    );
  }
}
