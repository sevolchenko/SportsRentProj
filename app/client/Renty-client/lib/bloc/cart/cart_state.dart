import 'package:client/api/dto/response/product_preview.dart';
import 'package:client/common/service/cart.dart';

abstract class CartState {}

class CartLoadingState extends CartState {}

class CartUnAuthenticatedUserState extends CartState {}

class CartLoadedState extends CartState {
  final Cart cart;
  // final List<ProductPreviewResponse> products;

  CartLoadedState({required this.cart});
}

class RentCartItemsState extends CartState {}

class CartErrorState extends CartState {
  CartErrorState({required this.errorMessage});
  final String errorMessage;
}
