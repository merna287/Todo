import 'dart:convert';

class RememberedAccount {
  final String email;
  final String password;
  final DateTime savedAt;

  RememberedAccount({
    required this.email,
    required this.password,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'savedAt': savedAt.toIso8601String(),
  };

  factory RememberedAccount.fromJson(Map<String, dynamic> json) {
    return RememberedAccount(
      email: json['email'] as String,
      password: json['password'] as String,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );
  }

  String toJsonString() => jsonEncode(toJson());

  factory RememberedAccount.fromJsonString(String jsonString) {
    return RememberedAccount.fromJson(jsonDecode(jsonString));
  }

  @override
  String toString() => 'RememberedAccount(email: $email, savedAt: $savedAt)';
}
