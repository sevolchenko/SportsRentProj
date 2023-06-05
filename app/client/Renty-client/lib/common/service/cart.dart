import 'package:client/api/dto/request/rent/start_rent_event.dart';
import 'package:client/api/dto/response/product/product_preview.dart';
import 'package:client/common/widgets/auxiliary_wigets.dart';

class Cart {
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;

  Cart._internal();

  List<StartRentEventRequest> _rents = [];
  List<ProductPreviewResponse> _proudcts = [];

  set setRents(List<StartRentEventRequest> newRents) {
    _rents = newRents;
  }

  set setProducts(List<ProductPreviewResponse> newProducts) {
    _proudcts = newProducts;
  }

  void addRentItem(StartRentEventRequest rent, ProductPreviewResponse product) {
    _rents.add(rent);
    _proudcts.add(product);
    toastInfo(msg: "Товар добавлен в корзину");
  }

  void removeRentItem(
      StartRentEventRequest rent, ProductPreviewResponse product) {
    _rents.remove(rent);
    _proudcts.remove(product);
  }

  void removeAll() {
    _rents.removeRange(0, _rents.length);
    _proudcts.removeRange(0, _proudcts.length);
  }

  List<StartRentEventRequest> get setRents => _rents;
  List<ProductPreviewResponse> get setProducts => _proudcts;
}
