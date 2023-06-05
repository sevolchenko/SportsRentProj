import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/product/product_preview.dart';

abstract class CartEvent {
  const CartEvent();
}

class CartLoadEvent extends CartEvent {}

class RemoveCartItemEvent extends CartEvent {
  final StartRentEventRequest startRentEventRequest;
  final ProductPreviewResponse product;
  RemoveCartItemEvent(
      {required this.startRentEventRequest, required this.product});
}

class RentCartItemsEvent extends CartEvent {
  final List<StartRentEventRequest> startRentRequest;
  RentCartItemsEvent({required this.startRentRequest});
}
