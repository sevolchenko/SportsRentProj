import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';

class ProductCreateRequest {
  final String name;
  final String description;
  final int price;
  final CategoryPreviewResponse category;
  final List<ImageResponse> images;

  ProductCreateRequest(
      {required this.name,
      required this.description,
      required this.price,
      required this.category,
      required this.images});

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'images': images,
      };
}
