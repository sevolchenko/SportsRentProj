class UserResponse {
  final int userId;
  final String role;
  final String token;

  UserResponse({required this.userId, required this.role, required this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        userId: json['user_id'], role: json['role'], token: json['token']);
  }
}
