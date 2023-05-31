import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/size.dart';

abstract class ProductState {}

class ProductLoadingState extends ProductState {}

class ProductLoadedState extends ProductState {
  final ProductResponse productItem;
  final List<SizeResponse> sizes;

  ProductLoadedState({required this.productItem, required this.sizes});
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

class ProductsErrorState extends ProductState {
  ProductsErrorState({required this.errorMessage});
  final String errorMessage;
}
