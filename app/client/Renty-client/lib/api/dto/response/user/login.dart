class LoginResponse {
  final int userId;
  final String role;
  final String token;

  LoginResponse({required this.userId, required this.role, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        userId: json['user_id'], role: json['role'], token: json['token']);
  }
}
