import 'package:client/api/dto/response/product.dart';
import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductEvent extends ProductEvent {
  final int productId;

  const FetchProductEvent({required this.productId});

  @override
  List<Object> get props => [productId];
}
