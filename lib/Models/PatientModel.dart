class PatientModel {
  String address;
  String cnic;
  String phoneNumber;
  String gender;
  String cardNumber;
  String userId;

  PatientModel(
      {required this.address,
      required this.cnic,
      required this.phoneNumber,
      required this.gender,
      required this.cardNumber,
      required this.userId});

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'cnic': cnic,
      'phoneNumber': phoneNumber,
      'gender': gender,
      'cardNumber': cardNumber,
      'userId': userId
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
        address: map['address'] ?? "",
        cnic: map['cnic'] ?? "",
        phoneNumber: map['phoneNumber'] ?? "",
        gender: map['gender'] ?? "",
        cardNumber: map['cardNumber'] ?? "",
        userId: map['userId'] ?? "");
  }
}
