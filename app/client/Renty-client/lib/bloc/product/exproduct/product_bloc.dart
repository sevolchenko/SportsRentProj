import 'package:client/api/dto/response/product.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/bloc/product/exproduct/product_event.dart';
import 'package:client/bloc/product/exproduct/product_state.dart';
import 'package:client/bloc/product/exproduct/product_event.dart';
import 'package:client/controller/product_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

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

// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   final ProductController productController;

//   ProductBloc(this.productController) : super(ProductLoadingState()) {
//     on<LoadProductEvent>((event, emit) async {
//       emit(ProductLoadingState());
//       try {
//         final users = await productController.getProductById();
//         emit(ProductLoadedState(users));
//       } catch (e) {
//         emit(ProductErrorState(e.toString()));
//       }
//     });
//   }
// }

class TestProductBloc {
  final ProductRepository _repository = ProductRepository();
  final BehaviorSubject<ProductResponse> _subject =
      BehaviorSubject<ProductResponse>();

  getProductById(productId) async {
    ProductResponse response = await _repository.getProductById(productId);
    _subject.sink.add(response);
    return response;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ProductResponse> get subject => _subject;
}

final bloc = TestProductBloc();
