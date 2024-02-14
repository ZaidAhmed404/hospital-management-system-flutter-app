class UserModel {
  String uid;
  String displayName;
  String email;
  String phoneNumber;
  String photoUrl;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
  });

  // You can also add a named constructor for creating an instance from a map
  UserModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        displayName = map['displayName'],
        email = map['email'],
        phoneNumber = map['phoneNumber'],
        photoUrl = map['photoUrl'];

  // You can add a method to convert the object to a map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
    };
  }
}
