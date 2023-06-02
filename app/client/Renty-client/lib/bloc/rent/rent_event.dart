abstract class RentEvent {
  const RentEvent();
}

class MyRentsLoadEvent extends RentEvent {}

class UserRentsLoadEvent extends RentEvent {
  final int userId;

  UserRentsLoadEvent(this.userId);
}

class FinishRentEvent extends RentEvent {
  final int userId;

  FinishRentEvent(this.userId);
}

class StartRentEvent extends RentEvent {
  final int productId;
  final String sizeName;
  final int count;
  final String startTime;
  final String endTime;
  StartRentEvent(
      this.productId, this.sizeName, this.count, this.startTime, this.endTime);
}
