class UserModel {
  String uid;
  String displayName;
  String email;
  String photoUrl;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] ?? "",
        displayName = map['displayName'] ?? "",
        email = map['email'] ?? "",
        photoUrl = map['photoUrl'] ?? "";

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }
}
