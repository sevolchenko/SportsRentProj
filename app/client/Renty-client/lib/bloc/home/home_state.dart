import 'package:client/api/dto/response/product_projection.dart';

class HomeState {
  const HomeState({
    this.productProjectionItem = const <ProductProjectionResponse>[],
  });

  final List<ProductProjectionResponse> productProjectionItem;
  HomeState copyWith({List<ProductProjectionResponse>? productProjectionItem}) {
    return HomeState(
      productProjectionItem: productProjectionItem??this.productProjectionItem,
    );
  }
}
