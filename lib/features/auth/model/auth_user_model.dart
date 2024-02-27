class AuthUserModel {
  final String username;
  final String password;

  AuthUserModel({required this.username, required this.password});

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
        username: json['username'], password: json['password']);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
