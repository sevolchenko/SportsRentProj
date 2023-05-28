import 'package:client/api/dto/response/product.dart';

abstract class ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final ProductResponse productItem;

  ProductLoadedState({required this.productItem});
}

class ProductErrorState extends ProductState {
  ProductErrorState({required this.errorMessage});
  final String errorMessage;
}



class ProductsLoadingState extends ProductState {}

class ProductsLoadedState extends ProductState {
  final List<ProductResponse> products;

  ProductsLoadedState({required this.products});
}


class ProductSizeCountUpdatedState extends ProductState {

}

class ProductsErrorState extends ProductState {
  ProductsErrorState({required this.errorMessage});
  final String errorMessage;
}
