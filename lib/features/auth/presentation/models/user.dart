class User {
  User({
    this.sId = "",
    this.name = "",
    this.email = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.iV = 0,
  });

  String sId;
  String name;
  String email;
  String createdAt;
  String updatedAt;
  int iV;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      sId: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      iV: json["__v"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": sId,
      "name": name,
      "email": email,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "__v": iV,
    };
  }
}