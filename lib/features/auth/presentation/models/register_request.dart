class RegisterRequest {
  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String password;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
    };
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"] ?? "",
    );
  }
}