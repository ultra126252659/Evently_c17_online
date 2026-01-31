class UserModel{
  String id;
  String name;
  String email;
  bool isVerified;
  UserModel({
    this.id = "",
    required this.name,
    required this.email,
    this.isVerified = false});

  UserModel.fromJson(Map<String, dynamic> json):this(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    isVerified: json["isVerified"],
  );
  Map<String, dynamic> toJson(){
    return{
      "id":id,
      "name":name,
      "email":email,
      "isVerified":isVerified,
    };
  }
}