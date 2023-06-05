import 'package:client/api/dto/request/product/image_create.dart';
import 'package:client/api/dto/response/product/category.dart';
import 'package:client/api/dto/response/product/image.dart';

class ProductCreateRequest {
  final String name;
  final String description;
  final int price;
  final int categoryId;
  final List<ImageCreateRequest> images;

  ProductCreateRequest(
      {required this.name,
      required this.description,
      required this.price,
      required this.categoryId,
      required this.images});

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'category_id': categoryId,
        'images': images,
      };
}

