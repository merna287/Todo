import 'user.dart';

class RegisterResponse {
  RegisterResponse({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
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