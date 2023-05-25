import 'package:client/api/dto/response/product_preview.dart';

class HomeState {
  const HomeState({
    this.productProjectionItem = const <ProductPreviewResponse>[],
  });

  final List<ProductPreviewResponse> productProjectionItem;
  HomeState copyWith({List<ProductPreviewResponse>? productProjectionItem}) {
    return HomeState(
      productProjectionItem:
          productProjectionItem ?? this.productProjectionItem,
    );
  }
}
