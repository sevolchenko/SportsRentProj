class UserResponse {
  final int userId;
  final String email;
  final String name;
  final String role;

  UserResponse(
      {required this.userId,
      required this.email,
      required this.name,
      required this.role});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
        userId: json['user_id'],
        email: json['email'],
        name: json['name'],
        role: json['role']);
  }
}
