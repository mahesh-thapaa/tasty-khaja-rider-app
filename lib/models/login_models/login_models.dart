class LoginModels {
  final String email;
  final String password;

  final String? id;
  final String? fullName;
  final String? role;

  LoginModels({
    required this.email,
    required this.password,
    this.id,
    this.fullName,
    this.role,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginModels.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] ?? {};

    return LoginModels(
      email: userMap['email'] ?? '',
      password: '',
      id: userMap['id'] ?? '',
      fullName: userMap['fullName'] ?? '',
      role: userMap['role'] ?? '',
    );
  }
}
