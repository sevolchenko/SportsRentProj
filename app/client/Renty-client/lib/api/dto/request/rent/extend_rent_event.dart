class ExtendRentEventRequest {
  final String newEndTime;

  ExtendRentEventRequest({required this.newEndTime});

  Map<String, dynamic> toJson() => {
        'end_time': newEndTime,
      };
}
