import 'package:client/api/dto/response/product/product.dart';
import 'package:client/api/dto/response/product/size.dart';

abstract class SizeState {}

class SizesLoadingStateState extends SizeState {}


class SizesLoadedState extends SizeState {
  final ProductResponse product;

  SizesLoadedState({required this.product});
}

class ProductSizeCreateState extends SizeState {
  ProductSizeCreateState();
}

class ProductSizeDeleteState extends SizeState {
  ProductSizeDeleteState();
}

class ProductSizeCountUpdatedState extends SizeState {
  ProductSizeCountUpdatedState();
}

class SizesErrorState extends SizeState {
  SizesErrorState({required this.error});
  final String error;
}
