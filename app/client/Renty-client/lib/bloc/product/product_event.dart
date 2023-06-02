import 'package:client/api/dto/request/image_create.dart';
import 'package:client/api/dto/response/category.dart';
import 'package:client/api/dto/response/image.dart';
import 'package:client/api/dto/response/product.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {
  final int productId;
  ProductLoadEvent(this.productId);
}

class ProductsLoadEvent extends ProductEvent {}

class ProductsPreviewsLoadEvent extends ProductEvent {}

class ProductRentEvent extends ProductEvent {
  final String startTime;
  final String endTime;
  final int productId;
  final String sizeName;
  final int count;

  ProductRentEvent(
      {required this.startTime,
      required this.endTime,
      required this.productId,
      required this.sizeName,
      required this.count});
}

class DeleteProductEvent extends ProductEvent {
  final int productId;

  DeleteProductEvent(this.productId);
}

class PreCreateProductEvent extends ProductEvent {}

class CreateProductEvent extends ProductEvent {
  final int categoryId;
  final String name;
  final String description;
  final int price;
  final List<ImageCreateRequest> images;

  CreateProductEvent(
      this.categoryId, this.name, this.description, this.price, this.images);
}
