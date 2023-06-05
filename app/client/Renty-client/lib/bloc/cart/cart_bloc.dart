import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/api/repository/product_repository.dart';
import 'package:client/api/repository/rent_repository.dart';
import 'package:client/bloc/cart/cart_event.dart';
import 'package:client/bloc/cart/cart_state.dart';
import 'package:client/global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final RentRepository _rentRepository = RentRepository();
  final ProductRepository _productRepository = ProductRepository();
  late List<ProductPreviewResponse> _products;
  // late List<RentResponse> myRents = [];

  CartBloc() : super(CartLoadingState()) {
    on<CartLoadEvent>(
      (event, emit) async {
        if (Global.storageService.isUserAuthenticated()) {
          // myRents = await _rentRepository.getMyOngRents();
          // _products = await _productRepository.getProductsPreviews();
          emit(CartLoadedState(cart: Global.cart));
        } else {
          emit(CartUnAuthenticatedUserState());
        }
      },
    );

    on<RemoveCartItemEvent>(
      (event, emit) async {
        Global.cart.removeRentItem(event.startRentEventRequest, event.product);
        Global.storageService.saveCart(Global.cart);
        emit(CartLoadedState(cart: Global.cart));
      },
    );

    on<RentCartItemsEvent>(
      (event, emit) async {
        List<StartRentEventRequest> listRequests = [];
        for (var rent in Global.cart.setRents) {
          listRequests.add(StartRentEventRequest.fromJson(rent.toJson()));
        }
        _rentRepository.startRents({"rents": listRequests});
        Global.cart.removeAll();
        Global.storageService.saveCart(Global.cart);
        emit(CartLoadedState(cart: Global.cart));
      },
    );
  }
}
