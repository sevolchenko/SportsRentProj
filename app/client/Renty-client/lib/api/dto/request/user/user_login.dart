class UserLoginequest {
  final String email;
  final String password;

  UserLoginequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}