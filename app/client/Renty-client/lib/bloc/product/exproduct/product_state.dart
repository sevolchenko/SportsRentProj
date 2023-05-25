import 'package:client/api/dto/response/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// abstract class ProductState extends Equatable {
//   const ProductState();

//   @override
//   List<Object> get props => [];
// }

// class ProductInitialState extends ProductState {}

// class ProductLoadingState extends ProductState {}

// class ProductLoadedState extends ProductState {
//   final ProductResponse product;

//   const ProductLoadedState({required this.product});

//   @override
//   List<Object> get props => [product];
// }

// class ProductErrorState extends ProductState {
//   final String errorMessage;

//   const ProductErrorState({required this.errorMessage});

//   @override
//   List<Object> get props => [errorMessage];
// }


@immutable
abstract class ProductState extends Equatable {}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadedState extends ProductState {
  final List<ProductResponse> products;
  ProductLoadedState(this.products);
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String error;
  ProductErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
