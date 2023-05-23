import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(const ProductState()) {
    on<HomeProductItem>(_homeProductProjectionUtem);
  }

  void _homeProductProjectionUtem(HomeProductItem event, Emitter<ProductState> emit){
    emit(state.copyWith(productItem: event.productItem));  
  }
}