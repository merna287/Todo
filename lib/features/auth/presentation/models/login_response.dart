import 'user.dart';

class LoginResponse {
  LoginResponse({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: json["user"] != null ? User.fromJson(json["user"]) : null,
      token: json["token"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user": user?.toJson(),
      "token": token,
    };
  }
}