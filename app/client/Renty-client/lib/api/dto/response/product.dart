import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';
import 'package:client/api/dto/response/size.dart';

class ProductResponse {
  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final SizeListResponse? sizes;
  final CategoryPreviewResponse? category;
  final ImageListResponse? images;

  const ProductResponse(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.sizes,
      this.category,
      this.images});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      sizes: json['sizes'] = SizeListResponse.fromJson(json['sizes']),
      category: json['category'] =
          CategoryPreviewResponse.fromJson(json['category']),
      images: json['images'] = ImageListResponse.fromJson(json['images'])
    );
  }
}

class ProductListResponse {
  final List<ProductResponse> products;
  final int size;

  ProductListResponse({
    required this.products,
    required this.size,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
        products: json['products'] = List<ProductResponse>.from(
            json['products'].map((x) => ProductResponse.fromJson(x))),
        size: json['size']);
  }
}
