import 'package:client/api/dto/response/product.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// abstract class ProductEvent extends Equatable {
//   const ProductEvent();

//   @override
//   List<Object> get props => [];
// }

// class FetchProductEvent extends ProductEvent {
//   final int productId;

//   const FetchProductEvent({required this.productId});

//   @override
//   List<Object> get props => [productId];
// }

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class LoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}