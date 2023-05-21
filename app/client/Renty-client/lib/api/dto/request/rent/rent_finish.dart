class RentFinishRequest {
  final int rentId;
  final String finishTime;

  RentFinishRequest({
    required this.rentId,
    required this.finishTime,
  });

  Map<String, dynamic> toJson() => {
        'rent_id': rentId,
        'finish_time': finishTime,
      };
}

class ListRentFinishRequest {
  final List<RentFinishRequest> rents;
  final int size;

  ListRentFinishRequest({
    required this.rents,
    required this.size,
  });

  Map<String, dynamic> toJson() => {
        'rents': rents,
        'size': size,
      };
}
