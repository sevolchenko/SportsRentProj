import 'package:client/api/dto/response/product.dart';

abstract class ProductEvent {
  const ProductEvent();
}

class HomeProductItem extends ProductEvent {
  const HomeProductItem(this.productItem);
  final ProductResponse? productItem;
}