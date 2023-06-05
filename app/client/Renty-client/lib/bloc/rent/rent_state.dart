import 'package:client/api/dto/response/rent/rent.dart';

abstract class RentState {}

class RentsLoadingState extends RentState {}

class RentsUnAuthenticatedUserState extends  RentState {}

class UnsuccessfulUserSearchState extends  RentState {}


class RentsLoadedState extends RentState {
  final List<RentResponse> rents;

  RentsLoadedState({required this.rents});
}

class UserRentsLoadedState extends RentState {
  final int userId;
  final List<RentResponse> userRents;

  UserRentsLoadedState({required this.userId, required this.userRents});
}

class RentsErrorState extends RentState {
  RentsErrorState({required this.errorMessage});
  final String errorMessage;
}
