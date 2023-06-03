class UserRentsFinishRequest {
  final List<int> rentsId;

  UserRentsFinishRequest({
    required this.rentsId,
  });

  Map<String, dynamic> toJson() => {
        'rent_ids': rentsId,
      };
}
