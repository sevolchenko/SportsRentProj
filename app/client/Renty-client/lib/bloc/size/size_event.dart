import 'package:client/api/dto/response/product.dart';

abstract class SizeEvent {
  const SizeEvent();
}

class SizesLoadEvent extends SizeEvent {
  final int productId;

  SizesLoadEvent(this.productId);
}

class ProductSizeCreateEvent extends SizeEvent {
  final int productId;
  final String sizeName;
  final int productsCount;

  ProductSizeCreateEvent(this.productId, this.sizeName, this.productsCount);
}

class ProductSizeDeleteEvent extends SizeEvent {
  final int productId;
  final String sizeName;

  ProductSizeDeleteEvent(this.productId, this.sizeName);
}

class ProductSizeUpdateEvent extends SizeEvent {
  final ProductResponse product;
  final int sizeIndex;
  final int newTotal;
  ProductSizeUpdateEvent(this.product, this.sizeIndex, this.newTotal);
}
