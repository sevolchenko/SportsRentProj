import 'package:client/api/dto/request/product/image_create.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {
  final int productId;
  ProductLoadEvent(this.productId);
}

class ProductsLoadEvent extends ProductEvent {}

class ProductUnAuthenticatedUserEvent extends ProductEvent {}

class ProductsPreviewsLoadEvent extends ProductEvent {}

class ProductsPreviewsSearchEvent extends ProductEvent {
  final String search;
  ProductsPreviewsSearchEvent({required this.search});
}

class ProductsPreviewsSortEvent extends ProductEvent {
  final Map<String, String> sortValue;
  ProductsPreviewsSortEvent({required this.sortValue});
}

class ProductsPreviewsFilterEvent extends ProductEvent {
  final int categoryId;
  final int minPrice;
  final int maxPrice;
  ProductsPreviewsFilterEvent(
      {required this.categoryId,
      required this.minPrice,
      required this.maxPrice});
}

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

class CreateProductEvent extends ProductEvent {
  final int categoryId;
  final String name;
  final String description;
  final int price;
  final List<ImageCreateRequest> images;

  CreateProductEvent(
      this.categoryId, this.name, this.description, this.price, this.images);
}
