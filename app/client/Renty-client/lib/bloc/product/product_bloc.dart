import 'package:client/api/dto/request/size.dart';
import 'package:client/api/dto/response/product.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/bloc/product/product_event.dart';
import 'package:client/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository = ProductRepository();
  late ProductResponse product;
  late List<ProductResponse> products;

  // final sizeCountController = StreamController<String>();
  // Stream<String> get sizeCountStream => sizeCountController.stream;

  ProductBloc() : super(ProductLoadingState()) {
    on<ProductLoadEvent>(
      (event, emit) async {
        product = await _productRepository.getProductById(event.productId);
        emit(ProductLoadedState(productItem: product));
      },
    );
    on<ProductsLoadEvent>(
      (event, emit) async {
        products = await _productRepository.getProducts();
        emit(ProductsLoadedState(products: products));
      },
    );

    on<ProductSizeUpdateEvent>((event, emit) async {
      SizeUpdateRequest sizeUpdateRequest =
          SizeUpdateRequest(sizeName: event.product.sizes![event.sizeIndex].sizeName, total: event.newTotal);
      var jsonData = sizeUpdateRequest.toJson();
      var code =
          await _productRepository.sizeCountUpdate(event.product.id!, jsonData);
      if (code != null) {
        event.product.sizes![event.sizeIndex].total = event.newTotal;
      }
      // emit(ProductsLoadedState(products: products));
    });

    // on<HomeProductItem>(_homeProductProjectionUtem);
  }

  // void _homeProductProjectionUtem(
  //     HomeProductItem event, Emitter<ProductLoadedState> emit) {
  //   emit(state.copyWith(productItem: event.productItem));
  // }
}
