import 'package:client/api/dto/response/rent/rent.dart';

abstract class RentState {}

class RentsLoadingState extends RentState {}

class RentsUnAuthenticatedUserState extends RentState {}

class UnsuccessfulUserSearchState extends RentState {}

class RentsLoadedState extends RentState {
  final List<RentResponse> rents;

  RentsLoadedState({required this.rents});
}

class UserRentsLoadedState extends RentState {
  final int userId;
  final List<RentResponse> userRents;

  UserRentsLoadedState({required this.userId, required this.userRents});
}

class PaymentRentsState extends RentState {
  final String payLink;
  final int sum;

  PaymentRentsState({required this.payLink, required this.sum});
}

class RentsErrorState extends RentState {
  RentsErrorState({required this.errorMessage});
  final String errorMessage;
}
