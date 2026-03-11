class LoginRequest {
  LoginRequest({
    required this.email,
    required this.password,
  });

  String email;
  String password;

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }
}