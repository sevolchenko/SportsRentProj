import 'package:client/api/dto/response/product_projection.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeProductProjectionItem extends HomeEvent {
  const HomeProductProjectionItem(this.productProjectionItem);
  final List<ProductProjectionResponse>? productProjectionItem;
}
