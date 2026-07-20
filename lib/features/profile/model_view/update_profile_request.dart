class UpdateProfileRequest {
  final String? name;
  final String? email;
  final String? password;

  UpdateProfileRequest({
    this.name,
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null && name!.isNotEmpty) "name": name,
      if (email != null && email!.isNotEmpty) "email": email,
      if (password != null && password!.isNotEmpty)
        "password": password,
    };
  }
}