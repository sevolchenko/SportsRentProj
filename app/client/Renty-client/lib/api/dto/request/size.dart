class SizeCreateRequest {
  final String sizeName;
  final int total;

  SizeCreateRequest({
    required this.sizeName,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
        'size_name': sizeName,
        'total': total,
      };
}

class SizeDeleteRequest {
  final String sizeName;

  SizeDeleteRequest({
    required this.sizeName,
  });

  Map<String, dynamic> toJson() => {
        'size_name': sizeName,
      };
}

class SizeUpdateRequest {
  final String sizeName;
  final int total;

  SizeUpdateRequest({
    required this.sizeName,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
        'size_name': sizeName,
        'total': total,
      };
}
