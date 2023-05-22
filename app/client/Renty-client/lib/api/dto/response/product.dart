import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';
import 'package:client/api/dto/response/size.dart';

class ProductResponse {
  final int id;
  final String name;
  final String description;
  final int price;
  final List<SizeResponse> sizes;
  final CategoryPreviewResponse category;
  final List<ImageResponse> images;

  ProductResponse(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.sizes,
      required this.category,
      required this.images});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
        id: json['product_id'],
        name: json['name'],
        description: json['description'],
        price: json['price'],
        sizes: json['sizes'],
        category: json['category'],
        images: json['images']);
  }
}

class ProductListResponse {
  final ProductResponse products;
  final int size;

  ProductListResponse({
    required this.products,
    required this.size,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(products: json['products'], size: json['size']);
  }
}
