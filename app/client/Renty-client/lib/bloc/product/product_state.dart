import 'package:client/api/dto/response/product.dart';

class ProductState {
  const ProductState({
    this.productItem = const ProductResponse(),
  });

  final ProductResponse productItem;
  ProductState copyWith({ProductResponse? productItem}) {
    return ProductState(
      productItem: productItem!,
    );
  }
}
