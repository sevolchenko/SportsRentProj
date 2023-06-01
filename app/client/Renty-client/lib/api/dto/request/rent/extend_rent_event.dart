class ExtendRentEventRequest {
  final int newEndTime;

  ExtendRentEventRequest({required this.newEndTime});

  Map<String, dynamic> toJson() => {
        'new_end_time': newEndTime,
      };
}
