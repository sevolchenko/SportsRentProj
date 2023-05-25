// import 'package:client/bloc/product/exproduct/product_event.dart';
// import 'package:client/bloc/product/exproduct/product_state.dart';
// import 'package:client/bloc/product/product_event.dart';
// import 'package:client/bloc/product/product_state.dart';
// import 'package:client/controller/product_controller.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductController _productController;

//   ProductBloc({required ProductController productController})
//       : _productController = productController,
//         super(ProductInitialState());

//   @override
//   Stream<ProductState> mapEventToState(ProductEvent event) async* {
//     if (event is FetchProductEvent) {
//       yield ProductLoadingState();
//       try {
//         final product = await _productController.getProduct(event.productId);
//         yield ProductLoadedState(product: product);
//       } catch (e) {
//         yield ProductErrorState(errorMessage: e.toString());
//       }
//     }
//   }
// }
