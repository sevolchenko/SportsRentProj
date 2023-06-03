

import 'package:client/api/dto/response/rent.dart';

abstract class RentState {}

class RentsLoadingState extends RentState {}

class RentsLoadedState extends RentState {
  final List<RentResponse> rents;

  RentsLoadedState({required this.rents});
}

class UserRentsLoadedState extends RentState {
  final List<RentResponse> userRents;

  UserRentsLoadedState({required this.userRents});
}

class RentsErrorState extends RentState {
  RentsErrorState({required this.errorMessage});
  final String errorMessage;
}