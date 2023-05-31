import 'package:client/api/dto/request/size.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/dto/response/size.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/bloc/size/size_event.dart';
import 'package:client/bloc/size/size_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizeBloc extends Bloc<SizeEvent, SizeState> {
  final ProductRepository _productRepository = ProductRepository();
  late ProductResponse product;

  SizeBloc() : super(SizesLoadingStateState()) {
    on<SizesLoadEvent>(
      (event, emit) async {
        product = await _productRepository.getProductById(event.productId);
        emit(SizesLoadedState(product: product));
      },
    );

    on<ProductSizeCreateEvent>(
      (event, emit) async {
        SizeCreateRequest sizeDeleteRequest = SizeCreateRequest(
            sizeName: event.sizeName, total: event.productsCount);
        var jsonData = sizeDeleteRequest.toJson();
        _productRepository.sizeCreate(event.productId, jsonData);
        product = await _productRepository.getProductById(event.productId);
        emit(ProductSizeCreateState());
      },
    );

    on<ProductSizeDeleteEvent>(
      (event, emit) async {
        SizeDeleteRequest sizeDeleteRequest =
            SizeDeleteRequest(sizeName: event.sizeName);
        var jsonData = sizeDeleteRequest.toJson();
        _productRepository.sizeDelete(event.productId, jsonData);
        product = await _productRepository.getProductById(event.productId);
        emit(ProductSizeDeleteState());
      },
    );

    on<ProductSizeUpdateEvent>(
      (event, emit) async {
        SizeUpdateRequest sizeUpdateRequest = SizeUpdateRequest(
            sizeName: event.product.sizes[event.sizeIndex].sizeName,
            total: event.newTotal);
        var jsonData = sizeUpdateRequest.toJson();
        await _productRepository.sizeCountUpdate(event.product.id, jsonData);
        event.product.sizes[event.sizeIndex].total = event.newTotal;
        emit(ProductSizeCountUpdatedState());
      },
    );
  }
}
