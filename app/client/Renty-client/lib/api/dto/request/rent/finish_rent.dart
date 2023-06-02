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
