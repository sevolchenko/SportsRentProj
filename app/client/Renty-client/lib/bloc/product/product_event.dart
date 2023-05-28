import 'package:client/api/dto/response/product.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class ProductLoadEvent extends ProductEvent {
  final int productId;
  ProductLoadEvent(this.productId);
}

class ProductsLoadEvent extends ProductEvent {}

class ProductSizeUpdateEvent extends ProductEvent {
  final ProductResponse product;
  final int sizeIndex;
  final int newTotal;
  ProductSizeUpdateEvent(this.product, this.sizeIndex, this.newTotal);
}

class ProductSizeDeleteEvent extends ProductEvent {
  final ProductResponse product;
  final int sizeIndex;

  ProductSizeDeleteEvent(this.product, this.sizeIndex);
}
