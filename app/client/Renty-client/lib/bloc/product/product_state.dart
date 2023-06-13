import 'package:client/api/dto/response/product/category.dart';
import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/api/dto/response/product/size.dart';

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

class ProductUnAuthenticatedUserState extends ProductState {}

class ProductsPreviewsLoadedState extends ProductState {
  final List<ProductPreviewResponse> productsPreviews;
  final List<CategoryResponse> categories;

  ProductsPreviewsLoadedState({required this.productsPreviews, required this.categories});
}

class ProductsLoadedState extends ProductState {
  final List<ProductResponse> products;

  ProductsLoadedState({required this.products});
}

class ProductsErrorState extends ProductState {
  ProductsErrorState({required this.errorMessage});
  final String errorMessage;
}

class CreateProductState extends ProductState {
  CreateProductState();
}

class DeleteProductState extends ProductState {
  DeleteProductState();
}
