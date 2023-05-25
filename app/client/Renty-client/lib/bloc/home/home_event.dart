import 'package:client/api/dto/response/product_preview.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeProductProjectionItem extends HomeEvent {
  const HomeProductProjectionItem(this.productProjectionItem);
  final List<ProductPreviewResponse>? productProjectionItem;
}
