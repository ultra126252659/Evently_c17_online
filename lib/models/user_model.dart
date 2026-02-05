class UserModel {
  String id;
  String name;
  String email;
  String nid;
  bool isVerified;

  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    this.isVerified = false,
    required this.nid,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    nid: json['nid'],
    isVerified: json['isVerified'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "nid": nid,
      "isVerified": isVerified,
    };
  }
}