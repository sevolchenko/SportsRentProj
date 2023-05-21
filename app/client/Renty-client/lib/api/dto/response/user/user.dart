class UserResponse {
  final int userId;
  final String email;
  final String name;

  UserResponse({required this.userId, required this.email, required this.name});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        userId: json['user_id'], email: json['email'], name: json['name']);
  }
}


class ListUserResponse {
  final List<UserResponse> users;
  final int size;

  ListUserResponse({
    required this.users,
    required this.size,
  });

  factory ListUserResponse.fromJson(Map<String, dynamic> json) {
    return ListUserResponse(
      users: json['users'],
      size: json['size'],
    );
  }
}
